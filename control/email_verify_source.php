 <?php

    /* 

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


    $Id: VerifyEmailAddress.php 58 2012-11-06 15:58:20Z visser $

    Email address verification with SMTP probes
    Dick Visser <dick@tienhuis.nl>

    INTRODUCTION

    This function tries to verify an email address using several techniques,
    depending on the configuration. 

    Arguments that are needed:

    $email (string)
    The address you are trying to verify

    $domainCheck (boolean)
    Check if any DNS MX records exist for domain part

    $verify (boolean)
    Use SMTP verify probes to see if the address is deliverable.

    $probe_address (string)
    This is the email address that is used as FROM address in outgoing
    probes. Make sure this address exists so that in the event that the
    other side does probing too this will work.

    $helo_address (string)
    This should be the hostname of the machine that runs this site.

    $return_errors (boolean)
    By default, no errors are returned. This means that the function will evaluate
    to TRUE if no errors are found, and false in case of errors. It is not possible
    to return those errors, because returning something would be a TRUE.
    When $return_errors is set, the function will return FALSE if the address
    passes the tests. If it does not validate, an array with errors is returned.


    A global variable $debug can be set to display all the steps.


    EXAMPLES

    Use more options to get better checking.
    Check only by syntax:  validateEmail('dick@tienhuis.nl')
    Check syntax + DNS MX records: validateEmail('dick@tienhuis.nl', true);   
    Check syntax + DNS records + SMTP probe:
    validateEmail('dick@tienhuis.nl', true, true, 'postmaster@tienhuis.nl', 'outkast.tienhuis.nl');


    WARNING

    This function works for now, but it may well break in the future.

*/
function validateEmail($email, $domainCheck = false, $verify = false, $probe_address='', $helo_address='', $return_errors=false) {
    global $debug;
    
    /*
    Time-outs.
    Be sure to have set PHP's "max_execution_time" to some value greater than the total time of the
    communication. This means of course also (a fair amount) larger than any of the next two values.
    Of course, large timeouts will cause the verification to take alot of time. There are servers
    that have configured such large delays that they are unsuitable for verifcation with a web page.

    TCP connect timeout (seconds). Some servers deliberately wait a while before responding (tarpitting). */
    $tcp_connect_timeout = 18000;
    /*
    Some server (exim) can be configured to wait before acknowledging. If you issues the next command
    too soon, it will drop the SMTP conversation with stuff like: "554 SMTP synchronization error".
    */
    $smtp_timeout = 6000;

    

    if($debug) {echo "<pre>";}

    # Check email syntax with regex
    if (preg_match('/^([a-zA-Z0-9\'\._\+-]+)\@((\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,7}|[0-9]{1,3})(\]?))$/', $email, $matches)) {
        $user = $matches[1];
        $domain = $matches[2];
        
        /*
            Some MTAs do not like people ringing their door bell too much.
            If this is the case, sender    verification will get your IP address
            blacklisted. This is a problem when your web server is also a
            mail server. If you MTA is Postfix, you can whitelist addresses
            so that they are not verified any more:
            in Postfix, see    http://www.postfix.org/ADDRESS_VERIFICATION_README.html#sender_always
            This list should be taken into account by this script, otherwise 
            your IP address will get blacklisted anyway.
            The code below ONLY works when the access list is of type 'pcre', see
            http://www.postfix.org/pcre_table.5.html for how to construct this.
        */
        /*
        $whitelist= '/etc/postfix/sender_access'; 
        if($exluded = explode("\n", @file_get_contents($whitelist))) {
            $regexes=array();
            foreach ($exluded as $line) {
                preg_match('/^(\/.*?\/)\s+OK/', $line, $matches);
                if(@$matches[1]) {
                    array_push($regexes, $matches[1]);
                }
            }
            foreach ($regexes as $regex) {
                preg_match($regex, "$user@$domain", $m);
                if(@$m[0]) {
                    if($debug) { echo "$whitelist contains matching whitelist regex '".$regex."'\n"; }
                    if($return_errors) {
                        # Give back details about the error(s).
                        # Return FALSE if there are no errors.
                        if(isset($error)) return htmlentities($error); else return false;
                    } else {
                        # 'Old' behaviour, simple to understand
                        if(isset($error)) return false; else return true;
                    }
                }
            } 
        }
        */
        
        # Check availability of  MX/A records
        if ($domainCheck) {
            if(function_exists('checkdnsrr')) {
                # Construct array of available mailservers
                getmxrr($domain, $mxhosts, $mxweight);
                if(count($mxhosts) > 0) {
                    for($i=0;$i<count($mxhosts);$i++){
                        $mxs[$mxhosts[$i]] = $mxweight[$i];
                    }
                    asort($mxs);
                    $mailers = array_keys($mxs);
                # No MX found, use A
                } elseif(checkdnsrr($domain, 'A')) {
                    $mailers[0] = gethostbyname($domain);
                } else {
                    $mailers=array();
            }
            } else {
            # DNS functions do not exist - we are probably on Win32.
            # This means we have to resort to other means, like the Net_DNS PEAR class.
            # For more info see http://pear.php.net
            # For this you also need to enable the mhash module (lib_mhash.dll).
            # Another way of doing this is by using a wrapper for Win32 dns functions like
            # the one descrieb at http://px.sklar.com/code.html/id=1304
                require_once 'Net/DNS.php';
                $resolver = new Net_DNS_Resolver();
                # Workaround for bug in Net_DNS, you have to explicitly tell the name servers
                #
                # ***********  CHANGE THIS TO YOUR OWN NAME SERVERS **************
                $resolver->nameservers = array ('217.149.196.6', '217.149.192.6');
                
                $mx_response = $resolver->query($domain, 'MX');
                $a_response  = $resolver->query($domain, 'A');
                if ($mx_response) {
                    foreach ($mx_response->answer as $rr) {
                            $mxs[$rr->exchange] = $rr->preference;
                    }
                    asort($mxs);
                    $mailers = array_keys($mxs);
                } elseif($a_response) {
                    $mailers[0] = gethostbyname($domain);
                } else {
                    $mailers = array();
                }
                
            }
            
            $total = count($mailers);
            # Query each mailserver
            if($total > 0 && $verify) {
                # Check if mailers accept mail
                for($n=0; $n < $total; $n++) {
                    # Check if socket can be opened
                    if($debug) { echo "Checking server $mailers[$n]...\n";}
                    $errno = 0;
                    $errstr = 0;
                    # Try to open up TCP socket
                    if($sock = @fsockopen($mailers[$n], 25, $errno , $errstr, $tcp_connect_timeout)) {
                        $response = fread($sock,8192);
                        if($debug) {echo "Opening up socket to $mailers[$n]... Succes!\n";}
                        stream_set_timeout($sock, $smtp_timeout);
                        $meta = stream_get_meta_data($sock);
                        if($debug) { echo "$mailers[$n] replied: $response\n";}
                        $cmds = array(
                            "HELO $helo_address",
                            "MAIL FROM: <$probe_address>",
                            "RCPT TO:<$email>",
                            "QUIT",
                            );
                            # Hard error on connect -> break out
                            # Error means 'any reply that does not start with 2xx '
                            if(!$meta['timed_out'] && !preg_match('/^2\d\d[ -]/', $response)) {
                                $error = "Error: $mailers[$n] said: $response\n";
                                break;
                            }
                            foreach($cmds as $cmd) {
                                $before = microtime(true);
                                fputs($sock, "$cmd\r\n");
                                $response = fread($sock, 4096);
                                $t = 1000*(microtime(true)-$before);
                                if($debug) {echo htmlentities("$cmd\n$response") . "(" . sprintf('%.2f', $t) . " ms)\n";}
                                if(!$meta['timed_out'] && preg_match('/^5\d\d[ -]/', $response)) {
                                    $error = "Unverified address: $mailers[$n] said: $response";
                                    break 2;
                                }
                            }
                            fclose($sock);
                            if($debug) { echo "Succesful communication with $mailers[$n], no hard errors, assuming OK";}
                            break;
                    } elseif($n == $total-1) {
                        $error = "None of the mailservers listed for $domain could be contacted";
                    }
                }
            } elseif($total <= 0) {
                $error = "No usable DNS records found for domain '$domain'";
            }
        }
    } else {
        $error = 'Address syntax not correct';
    }
    if($debug) { echo "</pre>";}
    if($return_errors) {
        # Give back details about the error(s).
        # Return FALSE if there are no errors.
        if(isset($error)) return nl2br(htmlentities($error)); else return false;
    } else {
        # 'Old' behaviour, simple to understand
        if(isset($error)) return false; else return true;
    }
}

?>

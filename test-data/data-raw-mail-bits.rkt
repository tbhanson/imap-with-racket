'((3) 0 () 0 () () (c (c 14620 c (u . #"Return-Path: <bounce-md_30261166.55869dd9.v1-b33f50af99484d2f830a34791626d5f4@mandrillapp.com>\r\nX-Original-To: uhClem@some-domain.com\r\nDelivered-To: uhClem@some-domain.com\r\nReceived: from mxb1.provider.net (mxb1.provider.net [208.80.4.163])\r\n\tby web02.provider.net (Postfix) with ESMTP id CACB2A52069\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 04:19:57 -0700 (PDT)\r\nReceived: from localhost (localhost [127.0.0.1])\r\n\tby mxb1.provider.net (Postfix) with ESMTP id C1F4812BEEC\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 04:19:57 -0700 (PDT)\r\nX-Virus-Scanned: Debian amavisd-new at mailb1.provider.net\r\nReceived: from mxb1.provider.net (localhost [127.0.0.1])\r\n\tby mxb1.provider.net (Postfix) with ESMTP id 63B4712B450\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 04:19:55 -0700 (PDT)\r\nX-Provider-Content-Filter: SpamAssassin score -0.099 (DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HTML_MESSAGE,RCVD_IN_DNSWL_NONE)\r\nX-Spam-Flag: NO\r\nX-Spam-Score: -0.1\r\nX-Spam-Level: \r\nX-Spam-Status: No, score=-0.1 required=7.0 tests=[DKIM_SIGNED=0.1,\r\n\tDKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HTML_MESSAGE=0.001,\r\n\tRCVD_IN_DNSWL_NONE=-0.0001] autolearn=disabled\r\nX-Provider-Spam-Status: Level 2 (High) (P0); Accepted (Neutral)\r\nReceived: from mandrill2.couchsurfing.com (mandrill2.couchsurfing.com [198.2.134.163])\r\n\t(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))\r\n\t(No client certificate requested)\r\n\tby mxb1.provider.net (Postfix) with ESMTPS\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 04:19:54 -0700 (PDT)\r\nDKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=mandrill; d=couchsurfing.com;\r\n h=From:Subject:To:Message-Id:Date:MIME-Version:Content-Type; i=noreply@couchsurfing.com;\r\n bh=+8JqCCXVrvJZ+pMRo1yCYCnc+Vs=;\r\n b=mEMy5yLIgrbsgY4b9RMkqhjmi1/k7F8AsFswHN+5ofyrPy25n+D7PEXNPL3FLPFrQqqBmLpbtbHL\r\n   nSK26QJMiJsOqGAEqOzIVQ13RCFAJKJx89k+XJgNDmWyVavCpo4DNTvjZVBqUb5Nwc5vFX1Rq0Qy\r\n   55JpcueUzyU9lstz/v8=\r\nDomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=mandrill; d=couchsurfing.com;\r\n b=iLtdmeNlXeWh03DeNmZ0vMLEJ4jaivMZB/wpb6tIRSqmFd9K/3m20otqGWD5ORlMFRT3Yp95uXG+\r\n   +SMxdtpQWgRcUL8qcj/33Sr/ZJrm/xl3ySBCFCasq3fGbO+L/UM3K1Uu5jLivSCl20eamsw+V0Tz\r\n   p0/mvdm7n4Zwr7f+lCA=;\r\nReceived: from pmta03.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mandrill2.couchsurfing.com id hgqetm1sau8v for <uhClem@some-domain.com>; Sun, 21 Jun 2015 11:19:53 +0000 (envelope-from <bounce-md_30261166.55869dd9.v1-b33f50af99484d2f830a34791626d5f4@mandrillapp.com>)\r\nDKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; \r\n i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1434885593; h=From : \r\n Subject : To : Message-Id : Date : MIME-Version : Content-Type : From : \r\n Subject : Date : X-Mandrill-User : List-Unsubscribe; \r\n bh=729ZDphHpIuaXB8Qd7byUBQ3EsZUQungnPEHqg6ZikM=; \r\n b=mkyZzHJbfaUYOTx6OQjWS3V51LOmU74xq8eTqEdZ6BSW+ViPjdbunpxeZund6to17xaN6H\r\n M95J5Kbvqbf6uNATup9Tb29P3zLMuRAjq3AkoNw/YZP0xKqhXhBod0EkNw0SKF3I8hSYumss\r\n HhFjcUfpYdIW9VmbW6bVZXwXEFn2I=\r\nFrom: Couchsurfing <noreply@couchsurfing.com>\r\nSubject: Discussions near Frankfurt\r\nReceived: from [54.236.208.93] by mandrillapp.com id b33f50af99484d2f830a34791626d5f4; Sun, 21 Jun 2015 11:19:53 +0000\r\nTo: <uhClem@some-domain.com>\r\nMessage-Id: <55869d9caed85_26f2391e9415544e@resque02.mail>\r\nX-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com\r\nX-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=30261166.b33f50af99484d2f830a34791626d5f4\r\nX-Mandrill-User: md_30261166\r\nDate: Sun, 21 Jun 2015 11:19:53 +0000\r\nMIME-Version: 1.0\r\nContent-Type: multipart/alternative; boundary=\"_av-DNnhTFBnJDUr0d_L7SrAkA\"\r\n\r\n")) c (c 14621 c (u . #"Return-Path: <AxdXWwgBCD1SUARTAV0FVgEICQIMU1QCa01bDnZDUAYAFxtdAgoVWwsdU1pcbAdQVgk@bounce.bluestatedigital.com>\r\nX-Original-To: uhClem@some-domain.com\r\nDelivered-To: uhClem@some-domain.com\r\nReceived: from mxa1.provider.net (mxa1.provider.net [208.80.4.161])\r\n\tby web02.provider.net (Postfix) with ESMTP id 0496BA5533B\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 07:38:26 -0700 (PDT)\r\nReceived: from localhost (localhost [127.0.0.1])\r\n\tby mxa1.provider.net (Postfix) with ESMTP id ED132360F95\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 07:38:25 -0700 (PDT)\r\nX-Virus-Scanned: Debian amavisd-new at maila1.provider.net\r\nReceived: from mxa1.provider.net (localhost [127.0.0.1])\r\n\tby mxa1.provider.net (Postfix) with ESMTP id D7C3E360CF1\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 07:38:23 -0700 (PDT)\r\nX-Provider-Content-Filter: SpamAssassin score 0.001 (DKIM_SIGNED,DKIM_VALID,HTML_MESSAGE,RCVD_IN_DNSWL_NONE)\r\nX-Spam-Flag: NO\r\nX-Spam-Score: 0.0\r\nX-Spam-Level: \r\nX-Spam-Status: No, score=0.0 required=7.0 tests=[DKIM_SIGNED=0.1,\r\n\tDKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001]\r\n\tautolearn=disabled\r\nX-Provider-Spam-Status: Level 2 (High) (P0); Accepted (Neutral)\r\nReceived: from mta-dock-front-19.bluestatedigital.com (mta-dock-front-19.bluestatedigital.com [64.94.250.108])\r\n\t(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))\r\n\t(No client certificate requested)\r\n\tby mxa1.provider.net (Postfix) with ESMTPS\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 07:38:23 -0700 (PDT)\r\nReceived: from bounce.bluestatedigital.com (unknown [10.0.200.136])\r\n\tby mta-dock-front-19.bluestatedigital.com (Postfix) with ESMTP id 3mDxLk4kR0z22jhH\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 14:38:22 +0000 (UTC)\r\nDKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;\r\n\td=bounce.bluestatedigital.com; s=bsdkey; t=1434897502;\r\n\tbh=luHo0vs0ZUtF42BJv38pKXVIw9jcRJrgmU5OXQ0uBEk=;\r\n\th=Date:To:From:Reply-to:Subject:List-Unsubscribe;\r\n\tb=pF0g7VZHcpWJ6xQidRlOhgvqMdT6AUZr5AzWSZELvaHNtpUEJP8UE/IJNfGzmDuF8\r\n\t WqXtuSAuSm0TDZ3sLu9slM7p3N2OWbAo8csGSMbHcmh3DuaOx6Z/jkeCVcH0ZLmREL\r\n\t CQvEbqe8eopLycEQAAuEZlht5vS21fjQG8aYwh2k=\r\nReceived: from phpmailer \r\n\tby bounce.bluestatedigital.com with local (PHPMailer);\r\n\tSun, 21 Jun 2015 14:38:22 +0000\r\nDate: Sun, 21 Jun 2015 14:38:22 +0000\r\nTo: Clem Uh <uhClem@some-domain.com>\r\nFrom: Al Franken <info@alfranken.com>\r\nReply-to: info@alfranken.com\r\nSubject: Help us help Patty & Michael\r\nMessage-ID: <0be96ea010d44de1c6b7fa04ffec8cfb@bounce.bluestatedigital.com>\r\nX-Priority: 3\r\nX-Mailer: PHPMailer [version 1.71-blue_mailer]\r\nX-maillist-id: 7c4f0867b1908d11\r\nX-rpcampaign: rp_1098477\r\nX-maillist-guid: AxdXWwgBCD1SUARTAV0FVgEICQIMU1QCa01bDnZDUAYAFxtdAgoVWwsdU1pcbAdQVgk\r\nList-Unsubscribe: <http://action.alfranken.com/unsubscribe?email=uhClem@some-domain.com>, <mailto:AxdXWwgBCD1SUARTAV0FVgEICQIMU1QCa01bDnZDUAYAFxtdAgoVWwsdU1pcbAdQVgk@bounce.bluestatedigital.com>\r\nMIME-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n\tboundary=\"b1_0be96ea010d44de1c6b7fa04ffec8cfb\"\r\n\r\n")) c (c 14622 c (u . #"Return-Path: <return-5-16166-uhClem=some-domain.com@lists.readersupportednews.org>\r\nX-Original-To: uhClem@some-domain.com\r\nDelivered-To: uhClem@some-domain.com\r\nReceived: from mxa1.provider.net (mxa1.provider.net [208.80.4.161])\r\n\tby web02.provider.net (Postfix) with ESMTP id DBF89A56779\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 08:45:46 -0700 (PDT)\r\nReceived: from localhost (localhost [127.0.0.1])\r\n\tby mxa1.provider.net (Postfix) with ESMTP id BB941361158\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 08:45:46 -0700 (PDT)\r\nX-Virus-Scanned: Debian amavisd-new at maila1.provider.net\r\nReceived: from mxa1.provider.net (localhost [127.0.0.1])\r\n\tby mxa1.provider.net (Postfix) with ESMTP id 9043A360F06\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 08:45:44 -0700 (PDT)\r\nX-Provider-Content-Filter: SpamAssassin score -2.4 (DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HTML_MESSAGE,RCVD_IN_DNSWL_MED,SPF_HELO_PASS)\r\nX-Spam-Flag: NO\r\nX-Spam-Score: -2.4\r\nX-Spam-Level: \r\nX-Spam-Status: No, score=-2.4 required=7.0 tests=[DKIM_SIGNED=0.1,\r\n\tDKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HTML_MESSAGE=0.001,\r\n\tRCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001] autolearn=disabled\r\nX-Provider-Spam-Status: Level 2 (High) (P0); Accepted (Neutral)\r\nReceived: from lists.readersupportednews.org (lists.readersupportednews.org [208.75.213.188])\r\n\tby mxa1.provider.net (Postfix) with SMTP\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 08:45:42 -0700 (PDT)\r\nReceived: (qmail 16156 invoked by uid 520); 21 Jun 2015 15:45:40 -0000\r\nDKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed;\r\n\td=inbound.readersupportednews.org; s=default; h=Date:Message-ID:\r\n\tTo:Subject:From:MIME-Version:List-Unsubscribe:Content-Type; bh=P\r\n\tNqnRcp4ulwirRy6gpydbtBz2EE=; b=kZS8ydLb2ry74VOHHYydgLIfpUcXK66UK\r\n\t0NQF7oLSCSMO6HoN48Mp4rbNfZVr9TV\r\nDate: 21 Jun 2015 15:45:40 -0000\r\nMessage-ID: <20150621154540.16154.qmail@lists.readersupportednews.org>\r\nTo: uhClem@some-domain.com\r\nSubject: Marc Ash | TPP: Back to the Ramparts\r\nFrom: \"Reader Supported News\" <do-not-reply@inbound.readersupportednews.org>\r\nMIME-Version: 1.0\r\nX-Mailer-LID: 5\r\nX-Mailer-SID: 16166\r\nX-Mailer-Sent-By: 2\r\nX-Mailer-Info: AwLkAwRfrzWjYzSvMzShqF1ypz9lnxO6qzpfAD\r\nList-Unsubscribe: <http://lists.readersupportednews.org/ss/unsubscribe.php?M=138175&N=16166&L=5&C=a052f816df659ff0fcd2537d74cc4ee1>\r\nContent-Type: multipart/alternative; charset=\"UTF-8\"; boundary=\"b1_b85044194864f98893c098b161d1ab46\"\r\n\r\n")) c (c 14623 c (u . #"Return-Path: <return-5-16169-uhClem=some-domain.com@lists.readersupportednews.org>\r\nX-Original-To: uhClem@some-domain.com\r\nDelivered-To: uhClem@some-domain.com\r\nReceived: from mxb1.provider.net (mxb1.provider.net [208.80.4.163])\r\n\tby web02.provider.net (Postfix) with ESMTP id 337ABA56925\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 10:45:43 -0700 (PDT)\r\nReceived: from localhost (localhost [127.0.0.1])\r\n\tby mxb1.provider.net (Postfix) with ESMTP id 2A10D1202F9\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 10:45:43 -0700 (PDT)\r\nX-Virus-Scanned: Debian amavisd-new at mailb1.provider.net\r\nReceived: from mxb1.provider.net (localhost [127.0.0.1])\r\n\tby mxb1.provider.net (Postfix) with ESMTP id 4695C12257B\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 10:45:41 -0700 (PDT)\r\nX-Provider-Content-Filter: SpamAssassin score -2.4 (DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HTML_MESSAGE,RCVD_IN_DNSWL_MED,SPF_HELO_PASS)\r\nX-Spam-Flag: NO\r\nX-Spam-Score: -2.4\r\nX-Spam-Level: \r\nX-Spam-Status: No, score=-2.4 required=7.0 tests=[DKIM_SIGNED=0.1,\r\n\tDKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HTML_MESSAGE=0.001,\r\n\tRCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001] autolearn=disabled\r\nX-Provider-Spam-Status: Level 2 (High) (P0); Accepted (Neutral)\r\nReceived: from lists.readersupportednews.org (lists.readersupportednews.org [208.75.213.188])\r\n\tby mxb1.provider.net (Postfix) with SMTP\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 10:45:40 -0700 (PDT)\r\nReceived: (qmail 32357 invoked by uid 520); 21 Jun 2015 17:45:38 -0000\r\nDKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed;\r\n\td=inbound.readersupportednews.org; s=default; h=Date:Message-ID:\r\n\tTo:Subject:From:MIME-Version:List-Unsubscribe:Content-Type; bh=0\r\n\t1q+nAyCwO1hTEzn5tzGOTSUQp0=; b=0NCdCT1h2G9KX/D+N1wpVUUwFp6+XwbQN\r\n\twMWuaClddBXIR1xutw/bxtXCWJttwnj\r\nDate: 21 Jun 2015 17:45:38 -0000\r\nMessage-ID: <20150621174538.32355.qmail@lists.readersupportednews.org>\r\nTo: uhClem@some-domain.com\r\nSubject: We Need 285 Donations @ $30.\r\nFrom: \"Reader Supported News\" <do-not-reply@inbound.readersupportednews.org>\r\nMIME-Version: 1.0\r\nX-Mailer-LID: 5\r\nX-Mailer-SID: 16169\r\nX-Mailer-Sent-By: 2\r\nX-Mailer-Info: BGLkAwRfrzWjYzSvMzShqF1ypz9lnxO6qzpfAD\r\nList-Unsubscribe: <http://lists.readersupportednews.org/ss/unsubscribe.php?M=138175&N=16169&L=5&C=a052f816df659ff0fcd2537d74cc4ee1>\r\nContent-Type: multipart/alternative; charset=\"UTF-8\"; boundary=\"b1_11c0c29045f6d19e4e076305efe9e7b3\"\r\n\r\n")) c (c 14624 c (u . #"Return-Path: <2523626152-1333989-org2-org2DB@bounces.salsalabs.net>\r\nX-Original-To: uhClem@some-domain.com\r\nDelivered-To: uhClem@some-domain.com\r\nReceived: from mxa1.provider.net (mxa1.provider.net [208.80.4.161])\r\n\tby web02.provider.net (Postfix) with ESMTP id 9F1D7A5698F\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 12:38:33 -0700 (PDT)\r\nReceived: from localhost (localhost [127.0.0.1])\r\n\tby mxa1.provider.net (Postfix) with ESMTP id 92331360108\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 12:38:33 -0700 (PDT)\r\nX-Virus-Scanned: Debian amavisd-new at maila1.provider.net\r\nReceived: from mxa1.provider.net (localhost [127.0.0.1])\r\n\tby mxa1.provider.net (Postfix) with ESMTP id E141336020B\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 12:38:30 -0700 (PDT)\r\nX-Provider-Content-Filter: SpamAssassin score 0.001 (DKIM_SIGNED,DKIM_VALID,HTML_MESSAGE,RCVD_IN_DNSWL_NONE)\r\nX-Spam-Flag: NO\r\nX-Spam-Score: 0.0\r\nX-Spam-Level: \r\nX-Spam-Status: No, score=0.0 required=7.0 tests=[DKIM_SIGNED=0.1,\r\n\tDKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001]\r\n\tautolearn=disabled\r\nX-Provider-Spam-Status: Level 2 (High) (P0); Accepted (Neutral)\r\nReceived: from m166.salsalabs.net (m166.salsalabs.net [69.174.83.166])\r\n\tby mxa1.provider.net (Postfix) with ESMTP\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 12:38:29 -0700 (PDT)\r\nDKIM-Signature: v=1; a=rsa-sha1; d=mail.salsalabs.net; s=s1024-dkim; c=relaxed/relaxed;\r\n\tq=dns/txt; i=@mail.salsalabs.net; t=1434915508;\r\n\th=From:Subject:Date:To:MIME-Version:Content-Type;\r\n\tbh=CppnfhCq4Gk96B3ChnxfFnF0MP4=;\r\n\tb=vKjss+h4affEmIzeNoQuZTk3zWtdggLFAfZcbldsHMIIpX8AD3HnaZIFc8FH491u\r\n\t5fVx2HarYRUEE8b8dPFlSa25N9ZUm8C1oWNCeS+rQMjHo+ojL8FDX/q1DI/FlHUd\r\n\tGKVH7aO9LTvph9yTGopIQLX5IA5Hu2iqRZFKjDBn7k0=;\r\nReceived: from [10.174.83.200] ([10.174.83.200:58192] helo=dispatch9.salsalabs.net)\r\n\tby mailer1.salsalabs.net (envelope-from <2523626152-1333989-org2-org2DB@bounces.salsalabs.net>)\r\n\t(ecelerity 3.5.10.45038 r(Core:3.5.10.0)) with ESMTP\r\n\tid AD/A8-08408-4B217855; Sun, 21 Jun 2015 15:38:28 -0400\r\nDate: Sun, 21 Jun 2015 15:38:28 -0400 (EDT)\r\nFrom: t r u t h o u t <messenger@truthout.org>\r\nSender: messenger=truthout.org@mail.salsalabs.net\r\nReply-To: messenger@truthout.org\r\nTo: uhClem@some-domain.com\r\nMessage-ID: <2523626152.-1908842330@org2.org2DB.reply.salsalabs.com>\r\nSubject: China's Communist-Capitalist Ecological Apocalypse\r\nMIME-Version: 1.0\r\nContent-Type: multipart/alternative; \r\n\tboundary=\"----=_Part_15138870_631648656.1434915508928\"\r\nEnvelope-From: <2523626152-1333989-org2-org2DB@bounces.salsalabs.net>\r\nList-Unsubscribe: <http://org2.salsalabs.com/o/6694/p/salsa/supporter/unsubscribe/public/index.sjs?Email=uhClem@some-domain.com&email_blast_KEY=1333989>\r\nX_email_KEY: 2523626152\r\nX-campaignid: salsaorg26694-1333989\r\n\r\n")) c (c 14625 c (u . #"Return-Path: <return-5-16170-uhClem=some-domain.com@lists.readersupportednews.org>\r\nX-Original-To: uhClem@some-domain.com\r\nDelivered-To: uhClem@some-domain.com\r\nReceived: from mxb2.provider.net (mxb2.provider.net [208.80.4.164])\r\n\tby web02.provider.net (Postfix) with ESMTP id 2F802A568E0\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 12:46:37 -0700 (PDT)\r\nReceived: from localhost (localhost [127.0.0.1])\r\n\tby mxb2.provider.net (Postfix) with ESMTP id 263A38A0F90\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 12:46:37 -0700 (PDT)\r\nX-Virus-Scanned: Debian amavisd-new at b2.provider.net\r\nReceived: from mxb2.provider.net (localhost [127.0.0.1])\r\n\tby mxb2.provider.net (Postfix) with ESMTP id 3565C8A0FA8\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 12:46:35 -0700 (PDT)\r\nX-Provider-Content-Filter: SpamAssassin score -2.4 (DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HTML_MESSAGE,RCVD_IN_DNSWL_MED,SPF_HELO_PASS)\r\nX-Spam-Flag: NO\r\nX-Spam-Score: -2.4\r\nX-Spam-Level: \r\nX-Spam-Status: No, score=-2.4 required=7.0 tests=[DKIM_SIGNED=0.1,\r\n\tDKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HTML_MESSAGE=0.001,\r\n\tRCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001] autolearn=disabled\r\nX-Provider-Spam-Status: Level 2 (High) (P0); Accepted (Neutral)\r\nReceived: from lists.readersupportednews.org (lists.readersupportednews.org [208.75.213.188])\r\n\tby mxb2.provider.net (Postfix) with SMTP\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 12:46:34 -0700 (PDT)\r\nReceived: (qmail 10316 invoked by uid 520); 21 Jun 2015 19:46:31 -0000\r\nDKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed;\r\n\td=inbound.readersupportednews.org; s=default; h=Date:Message-ID:\r\n\tTo:Subject:From:MIME-Version:List-Unsubscribe:Content-Type; bh=f\r\n\t9ImxtIAWPbJYuSOBZTptF48kqI=; b=3TMfoooJvgKwRwJW9sqbYtwKJZJgaYP8+\r\n\t6RYD/PQKX82a+mDYBX7OOPl9zALvCCe\r\nDate: 21 Jun 2015 19:46:31 -0000\r\nMessage-ID: <20150621194631.10314.qmail@lists.readersupportednews.org>\r\nTo: uhClem@some-domain.com\r\nSubject: FOCUS: Kareem Abdul-Jabbar | It's Media Terrorism to Deny Charleston Was About Race\r\nFrom: \"Reader Supported News\" <do-not-reply@inbound.readersupportednews.org>\r\nMIME-Version: 1.0\r\nX-Mailer-LID: 5\r\nX-Mailer-SID: 16170\r\nX-Mailer-Sent-By: 2\r\nX-Mailer-Info: ZQpkAwRfrzWjYzSvMzShqF1ypz9lnxO6qzpfAD\r\nList-Unsubscribe: <http://lists.readersupportednews.org/ss/unsubscribe.php?M=138175&N=16170&L=5&C=a052f816df659ff0fcd2537d74cc4ee1>\r\nContent-Type: multipart/alternative; charset=\"UTF-8\"; boundary=\"b1_085333ce2724bc2a56140c4c3b777f45\"\r\n\r\n")) c (c 14626 c (u . #"Return-Path: <return-5-16173-uhClem=some-domain.com@lists.readersupportednews.org>\r\nX-Original-To: uhClem@some-domain.com\r\nDelivered-To: uhClem@some-domain.com\r\nReceived: from mxb2.provider.net (mxb2.provider.net [208.80.4.164])\r\n\tby web02.provider.net (Postfix) with ESMTP id B4D51A569D3\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 14:46:41 -0700 (PDT)\r\nReceived: from localhost (localhost [127.0.0.1])\r\n\tby mxb2.provider.net (Postfix) with ESMTP id A5B818A1365\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 14:46:41 -0700 (PDT)\r\nX-Virus-Scanned: Debian amavisd-new at b2.provider.net\r\nReceived: from mxb2.provider.net (localhost [127.0.0.1])\r\n\tby mxb2.provider.net (Postfix) with ESMTP id CA91F8A171B\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 14:46:39 -0700 (PDT)\r\nX-Provider-Content-Filter: SpamAssassin score -2.4 (DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HTML_MESSAGE,RCVD_IN_DNSWL_MED,SPF_HELO_PASS)\r\nX-Spam-Flag: NO\r\nX-Spam-Score: -2.4\r\nX-Spam-Level: \r\nX-Spam-Status: No, score=-2.4 required=7.0 tests=[DKIM_SIGNED=0.1,\r\n\tDKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HTML_MESSAGE=0.001,\r\n\tRCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001] autolearn=disabled\r\nX-Provider-Spam-Status: Level 2 (High) (P0); Accepted (Neutral)\r\nReceived: from lists.readersupportednews.org (lists.readersupportednews.org [208.75.213.188])\r\n\tby mxb2.provider.net (Postfix) with SMTP\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 14:46:39 -0700 (PDT)\r\nReceived: (qmail 29163 invoked by uid 520); 21 Jun 2015 21:46:36 -0000\r\nDKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed;\r\n\td=inbound.readersupportednews.org; s=default; h=Date:Message-ID:\r\n\tTo:Subject:From:MIME-Version:List-Unsubscribe:Content-Type; bh=+\r\n\tyhhIJSsKcCwazKAf77imrEuZ2I=; b=EYEr/O04nt0uY4iPVoA0U11psTCkYB0Ns\r\n\thdFwb5Gu39q1mkAAUoeSbrf+9SkiGYC\r\nDate: 21 Jun 2015 21:46:36 -0000\r\nMessage-ID: <20150621214636.29161.qmail@lists.readersupportednews.org>\r\nTo: uhClem@some-domain.com\r\nSubject: =?UTF-8?Q?Donations_Trickling_In_=E2=80=93_Work_With_Us?=\r\nFrom: \"Reader Supported News\" <do-not-reply@inbound.readersupportednews.org>\r\nMIME-Version: 1.0\r\nX-Mailer-LID: 5\r\nX-Mailer-SID: 16173\r\nX-Mailer-Sent-By: 2\r\nX-Mailer-Info: ZmpkAwRfrzWjYzSvMzShqF1ypz9lnxO6qzpfAD\r\nList-Unsubscribe: <http://lists.readersupportednews.org/ss/unsubscribe.php?M=138175&N=16173&L=5&C=a052f816df659ff0fcd2537d74cc4ee1>\r\nContent-Type: multipart/alternative; charset=\"UTF-8\"; boundary=\"b1_2b0693f5bd8c965d23822d8fddb7ddb8\"\r\n\r\n")) c (c 14627 c (u . #"Return-Path: <someone@usfamily.net>\r\nX-Original-To: uhClem@some-domain.com\r\nDelivered-To: uhClem@some-domain.com\r\nReceived: from mxb2.provider.net (mxb2.provider.net [208.80.4.164])\r\n\tby web02.provider.net (Postfix) with ESMTP id 5228DA569FC\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 15:50:50 -0700 (PDT)\r\nReceived: from localhost (localhost [127.0.0.1])\r\n\tby mxb2.provider.net (Postfix) with ESMTP id 485798C0050\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 15:50:50 -0700 (PDT)\r\nX-Virus-Scanned: Debian amavisd-new at b2.provider.net\r\nReceived: from mxb2.provider.net (localhost [127.0.0.1])\r\n\tby mxb2.provider.net (Postfix) with ESMTP id 1A6FF8C0011\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 15:50:50 -0700 (PDT)\r\nX-Provider-Content-Filter: Whitelisted\r\nX-Provider-Spam-Status: Level 0 (High) (P0); Whitelisted TTSSA (someone@usfamily.net whitelisted)\r\nReceived: from mail-05.usfamily.net (mail-05.usfamily.net [64.131.63.155])\r\n\t(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))\r\n\t(No client certificate requested)\r\n\tby mxb2.provider.net (Postfix) with ESMTPS\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 15:50:49 -0700 (PDT)\r\nReceived: from [71.193.71.69] by usfamily.net\r\n          (USGO MTA v5/:PHBhbWhhbnNvbkB1c2ZhbWlseS5uZXQ_PHRpbUB3ZWJlci1oYW5zb24uY29tPg--)\r\n          with SMTP id <20150621175044101432500011> for <uhClem@some-domain.com>;\r\n          Sun, 21 Jun 2015 17:50:44 -0500 (CDT)\r\n          (envelope-from someone@usfamily.net, authenticated user someone@usfamily.net)\r\nMessage-ID: <AE945EE8CFDE42BE856AF05707764DB5@AdminPC>\r\nFrom: \"Clementine\" <someone@usfamily.net>\r\nTo: \"Clem Uh\" <uhClem@some-domain.com>\r\nSubject: where I was today!\r\nX-Source-Date: Sun, 21 Jun 2015 17:50:44 -0500\r\nDate: Sun, 21 Jun 2015 17:50:44 -0500 (CDT)\r\nMIME-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n\tboundary=\"----=_NextPart_000_002D_01D0AC4A.CBF6C950\"\r\nX-Priority: 3\r\nX-MSMail-Priority: Normal\r\nImportance: Normal\r\nX-Mailer: Microsoft Windows Live Mail 15.4.3555.308\r\nX-MimeOLE: Produced By Microsoft MimeOLE V15.4.3555.308\r\n\r\n")) c (c 14628 c (u . #"Return-Path: <return-5-16174-uhClem=some-domain.com@lists.readersupportednews.org>\r\nX-Original-To: uhClem@some-domain.com\r\nDelivered-To: uhClem@some-domain.com\r\nReceived: from mxa1.provider.net (mxa1.provider.net [208.80.4.161])\r\n\tby web02.provider.net (Postfix) with ESMTP id C5B21A5688A\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 16:46:42 -0700 (PDT)\r\nReceived: from localhost (localhost [127.0.0.1])\r\n\tby mxa1.provider.net (Postfix) with ESMTP id BA887361290\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 16:46:42 -0700 (PDT)\r\nX-Virus-Scanned: Debian amavisd-new at maila1.provider.net\r\nReceived: from mxa1.provider.net (localhost [127.0.0.1])\r\n\tby mxa1.provider.net (Postfix) with ESMTP id D0F6C36138F\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 16:46:40 -0700 (PDT)\r\nX-Provider-Content-Filter: SpamAssassin score -2.4 (DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HTML_MESSAGE,RCVD_IN_DNSWL_MED,SPF_HELO_PASS)\r\nX-Spam-Flag: NO\r\nX-Spam-Score: -2.4\r\nX-Spam-Level: \r\nX-Spam-Status: No, score=-2.4 required=7.0 tests=[DKIM_SIGNED=0.1,\r\n\tDKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HTML_MESSAGE=0.001,\r\n\tRCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001] autolearn=disabled\r\nX-Provider-Spam-Status: Level 2 (High) (P0); Accepted (Neutral)\r\nReceived: from lists.readersupportednews.org (lists.readersupportednews.org [208.75.213.188])\r\n\tby mxa1.provider.net (Postfix) with SMTP\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 16:46:40 -0700 (PDT)\r\nReceived: (qmail 6882 invoked by uid 520); 21 Jun 2015 23:46:37 -0000\r\nDKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed;\r\n\td=inbound.readersupportednews.org; s=default; h=Date:Message-ID:\r\n\tTo:Subject:From:MIME-Version:List-Unsubscribe:Content-Type; bh=U\r\n\tzXOOHIJwV9IwP6XqJMPSo2Ua0A=; b=FAbna/pIez1CSsR1gabXa7aYZjOpEBvtb\r\n\t6W2aAAI/7OJvvHBg3pfb5c8woPYGwmf\r\nDate: 21 Jun 2015 23:46:37 -0000\r\nMessage-ID: <20150621234637.6880.qmail@lists.readersupportednews.org>\r\nTo: uhClem@some-domain.com\r\nSubject: FOCUS: Rev. Jesse Jackson | Charleston Shooting: We Need Prayer, but Also an End to This Political Genocide\r\nFrom: \"Reader Supported News\" <do-not-reply@inbound.readersupportednews.org>\r\nMIME-Version: 1.0\r\nX-Mailer-LID: 5\r\nX-Mailer-SID: 16174\r\nX-Mailer-Sent-By: 2\r\nX-Mailer-Info: AQpkAwRfrzWjYzSvMzShqF1ypz9lnxO6qzpfAD\r\nList-Unsubscribe: <http://lists.readersupportednews.org/ss/unsubscribe.php?M=138175&N=16174&L=5&C=a052f816df659ff0fcd2537d74cc4ee1>\r\nContent-Type: multipart/alternative; charset=\"UTF-8\"; boundary=\"b1_683ebdaaa173767a565a8e2a71dfc496\"\r\n\r\n")) c (c 14629 c (u . #"Return-Path: <return-5-16177-uhClem=some-domain.com@lists.readersupportednews.org>\r\nX-Original-To: uhClem@some-domain.com\r\nDelivered-To: uhClem@some-domain.com\r\nReceived: from mxb1.provider.net (mxb1.provider.net [208.80.4.163])\r\n\tby web02.provider.net (Postfix) with ESMTP id CE89AA5694A\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 18:46:45 -0700 (PDT)\r\nReceived: from localhost (localhost [127.0.0.1])\r\n\tby mxb1.provider.net (Postfix) with ESMTP id C3574121DE9\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 18:46:45 -0700 (PDT)\r\nX-Virus-Scanned: Debian amavisd-new at mailb1.provider.net\r\nReceived: from mxb1.provider.net (localhost [127.0.0.1])\r\n\tby mxb1.provider.net (Postfix) with ESMTP id EB65C120588\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 18:46:43 -0700 (PDT)\r\nX-Provider-Content-Filter: SpamAssassin score -2.4 (DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HTML_MESSAGE,RCVD_IN_DNSWL_MED,SPF_HELO_PASS)\r\nX-Spam-Flag: NO\r\nX-Spam-Score: -2.4\r\nX-Spam-Level: \r\nX-Spam-Status: No, score=-2.4 required=7.0 tests=[DKIM_SIGNED=0.1,\r\n\tDKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HTML_MESSAGE=0.001,\r\n\tRCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001] autolearn=disabled\r\nX-Provider-Spam-Status: Level 2 (High) (P0); Accepted (Neutral)\r\nReceived: from lists.readersupportednews.org (lists.readersupportednews.org [208.75.213.188])\r\n\tby mxb1.provider.net (Postfix) with SMTP\r\n\tfor <uhClem@some-domain.com>; Sun, 21 Jun 2015 18:46:43 -0700 (PDT)\r\nReceived: (qmail 24392 invoked by uid 520); 22 Jun 2015 01:46:40 -0000\r\nDKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed;\r\n\td=inbound.readersupportednews.org; s=default; h=Date:Message-ID:\r\n\tTo:Subject:From:MIME-Version:List-Unsubscribe:Content-Type; bh=j\r\n\t9N9rl1sXwiP41h7vQa7FRkU7jg=; b=w+6GtKLYf0qkBKijU2NvizoSDkj2vu10u\r\n\tLlpftk1BGzFGlD3OMGnFJ5G1UuzljIC\r\nDate: 22 Jun 2015 01:46:40 -0000\r\nMessage-ID: <20150622014640.24390.qmail@lists.readersupportednews.org>\r\nTo: uhClem@some-domain.com\r\nSubject: RSN, Tried and True\r\nFrom: \"Reader Supported News\" <do-not-reply@inbound.readersupportednews.org>\r\nMIME-Version: 1.0\r\nX-Mailer-LID: 5\r\nX-Mailer-SID: 16177\r\nX-Mailer-Sent-By: 2\r\nX-Mailer-Info: AmpkAwRfrzWjYzSvMzShqF1ypz9lnxO6qzpfAD\r\nList-Unsubscribe: <http://lists.readersupportednews.org/ss/unsubscribe.php?M=138175&N=16177&L=5&C=a052f816df659ff0fcd2537d74cc4ee1>\r\nContent-Type: multipart/alternative; charset=\"UTF-8\"; boundary=\"b1_7cb23a7f3d6ba34896855bdf0da799bd\"\r\n\r\n"))))
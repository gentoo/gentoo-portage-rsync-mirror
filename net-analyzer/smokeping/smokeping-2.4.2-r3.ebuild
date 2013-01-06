# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/smokeping/smokeping-2.4.2-r3.ebuild,v 1.8 2012/06/12 03:14:47 zmedico Exp $

EAPI="2"

inherit perl-module user

DESCRIPTION="A powerful latency measurement tool."
HOMEPAGE="http://oss.oetiker.ch/smokeping/"
SRC_URI="http://oss.oetiker.ch/smokeping/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa x86"
IUSE="apache2 speedy"

# dev-perl/JSON-1.x is bundled and is incompatible with version 2.x wich is in
# the tree. See http://bugs.gentoo.org/show_bug.cgi?id=260170#c2
DEPEND="dev-lang/perl
		virtual/perl-libnet
		>=net-analyzer/rrdtool-1.2[perl]
		>=net-analyzer/fping-2.4_beta2-r2
		dev-perl/Digest-HMAC
		dev-perl/libwww-perl
		dev-perl/CGI-Session
		>=dev-perl/SNMP_Session-1.13
		>=dev-perl/Socket6-0.20
		dev-perl/Net-DNS
		speedy? ( dev-perl/SpeedyCGI )
		!apache2? ( virtual/httpd-cgi )
		apache2? ( >=www-apache/mod_perl-2.0.1 )
		!dev-perl/Config-Grammar
		!dev-perl/JSON
		!perl-core/JSON-PP"

RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup smokeping
	enewuser smokeping -1 -1 /var/lib/smokeping smokeping
}

src_prepare() {
	rm -rf lib/Digest # provided by dev-perl/Digest-HMAC
	rm -rf lib/CGI # provided by dev-perl/CGI-Session
	rm -r lib/{BER.pm,SNMP_Session.pm,SNMP_util.pm} # dev-perl/SNMP_Session
	rm qooxdoo/qooxdoolink
}

src_compile() {
	# There is a makefile we don't want to run so leave this here
	einfo "Skip compile."
}

src_install() {
	# First move all the perl modules into the vendor lib area of Perl
	perlinfo
	insinto ${VENDOR_LIB}/
	doins -r lib/*

	# Install the CGI webserver scripts
	sed 's:^use lib:#use lib:g' -i htdocs/*.cgi.dist
	if use speedy; then
		sed '1{s:/usr/[^ ]*:/usr/bin/speedy:}' -i htdocs/*.cgi.dist
	else
		sed '1{s:/usr/[^ ]*:/usr/bin/perl:}' -i htdocs/*.cgi.dist
	fi
	sed 's:/home/oetiker.*/config.dist:/etc/smokeping/config:' \
			-i htdocs/*.cgi.dist
	exeinto /var/www/localhost/perl/
	newexe htdocs/smokeping.cgi.dist smokeping.pl || die
	exeinto /var/www/localhost/smokeping
	newexe htdocs/tr.cgi.dist tr.cgi || die
	rm htdocs/{tr,smokeping}.cgi.dist

	# Install AJAX scripts
	insinto /var/www/localhost/smokeping
	doins -r htdocs/* || die

	# Create the smokeping binaries
	for bin in ${PN} tSmoke; do
		newbin bin/${bin}.dist ${bin}
		dosed 's:^use lib:#use lib:g' /usr/bin/${bin}
		dosed 's:etc/config.dist:/etc/smokeping/config:' /usr/bin/${bin}
	done

	# Create the config files
	insinto /etc/${PN}
	for file in etc/*; do
		config=${file/.dist}
		newins ${file} ${config#*/}
	done
	sed -e '/^imgcache/{s:\(^imgcache[ \t]*=\).*:\1 /var/lib/smokeping/.simg:}' \
		-e '/^imgurl/{s:\(^imgurl[ \t]*=\).*:\1 ../.simg:}' \
		-e '/^datadir/{s:\(^datadir[ \t]*=\).*:\1 /var/lib/smokeping:}' \
		-e '/^piddir/{s:\(^piddir[ \t]*=\).*:\1 /var/run/smokeping:}' \
		-e '/^cgiurl/{s#\(^cgiurl[ \t]*=\).*#\1 http://some.place.xyz/perl/smokeping.pl#}' \
		-e '/^smokemail/{s:\(^smokemail[ \t]*=\).*:\1 /etc/smokeping/smokemail:}' \
		-e '/^tmail/{s:\(^tmail[ \t]*=\).*:\1 /etc/smokeping/tmail:}' \
		-e '/^secrets/{s:\(^secrets[ \t]*=\).*:\1 /etc/smokeping/smokeping_secrets:}' \
		-e '/^template/{s:\(^template[ \t]*=\).*:\1 /etc/smokeping/basepage.html:}' \
			-i "${D}/etc/${PN}/config" || die
	sed -e '/^<script/{s:cropper/:/cropper/:}' -i "${D}/etc/${PN}/basepage.html"
	fperms 700 /etc/${PN}/smokeping_secrets

	newinitd "${FILESDIR}/${PN}.init.2" ${PN} || die

	if use apache2 ; then
		insinto /etc/apache2/modules.d
		doins "${FILESDIR}/79_${PN}.conf" || die
	fi

	# Create the files in /var for rrd file storage
	keepdir /var/lib/${PN}/.simg
	fowners smokeping:smokeping /var/lib/${PN}
	if use apache2 ; then
		fowners apache:apache /var/lib/${PN}/.simg
	else
		fowners smokeping:smokeping /var/lib/${PN}/.simg
	fi
	fperms 775 /var/lib/${PN} /var/lib/${PN}/.simg

	# Install documentation.
	insinto "/usr/share/doc/${PF}"
	doins -r doc/examples
	dodoc CHANGES CONTRIBUTORS README TODO || die
	doman doc/{smokeping{.1,.cgi.1,_config.5},Smokeping.3,smokeping_examples.7} \
		doc/{smokeping_{extend,install,master_slave,upgrade}.7,smoketrace.7} \
			doc/{tSmoke.1,Smokeping/Smokeping::{Examples,RRDtools}.3} || die
}

pkg_postinst() {
	chown smokeping:smokeping "${ROOT}/var/lib/${PN}"
	chmod 755 "${ROOT}/var/lib/${PN}"
	elog
	elog "Additional steps are needed to get ${PN} up & running:"
	elog
	elog "First you need to edit /etc/${PN}/config. After that"
	elog "you can start ${PN} with '/etc/init.d/${PN} start'."
	elog
	if use apache2 ; then
		elog "For web interface make sure to add -D PERL to APACHE2_OPTS in"
		elog "/etc/conf.d/apache2 and to restart apache2. To access site from"
		elog "other places check permissions at /etc/apache2/modules.d/79_${PN}.conf"
		elog
	else
		elog "For web interface configure your web server to serve perl cgi"
		elog "script at /var/www/localhost/perl/"
	fi
	elog "To make cropper working you just need to copy /var/www/localhost/smokeping/cropper"
	elog "into you htdocs (or create symlink and allow webserver to follow symlinks)."
	elog
	elog "We install all files required for smoketrace, but you have to"
	elog "configure it manually. Just read 'man smoketrace'. Also you need to"
	elog "'emerge traceroute'."
	elog
}

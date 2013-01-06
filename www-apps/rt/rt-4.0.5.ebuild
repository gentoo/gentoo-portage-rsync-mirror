# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/rt/rt-4.0.5.ebuild,v 1.2 2012/03/01 20:56:31 radhermit Exp $

EAPI=4

inherit webapp eutils depend.apache

DESCRIPTION="RT is an enterprise-grade ticketing system"
HOMEPAGE="http://www.bestpractical.com/rt/"
SRC_URI="http://download.bestpractical.com/pub/${PN}/release/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE="mysql postgres fastcgi lighttpd"
REQUIRED_USE="|| ( mysql postgres )"

RESTRICT="test"

DEPEND="
	>=dev-lang/perl-5.8.3

	>=dev-perl/Apache-Session-1.53
	dev-perl/Cache-Simple-TimedExpiry
	dev-perl/Calendar-Simple
	dev-perl/CGI-Emulate-PSGI
	dev-perl/CGI-PSGI
	>=dev-perl/Class-Accessor-0.34
	>=dev-perl/class-returnvalue-0.40
	dev-perl/Convert-Color
	>=dev-perl/CSS-Squish-0.06
	dev-perl/Data-ICal
	dev-perl/DBD-SQLite
	>=dev-perl/DBI-1.37
	>=dev-perl/dbix-searchbuilder-1.59
	dev-perl/Devel-GlobalDestruction
	>=dev-perl/Devel-StackTrace-1.19
	dev-perl/Email-Address
	dev-perl/File-ShareDir
	dev-perl/GD
	dev-perl/GDGraph
	dev-perl/GDTextUtil
	dev-perl/GnuPG-Interface
	dev-perl/GraphViz
	dev-perl/HTML-Format
	>=dev-perl/HTML-Mason-1.43
	dev-perl/HTML-Mason-PSGIHandler
	dev-perl/HTML-Parser
	dev-perl/HTML-Quoted
	dev-perl/HTML-RewriteAttributes
	>=dev-perl/HTML-Scrubber-0.08
	dev-perl/HTML-Tree
	>=dev-perl/HTTP-Server-Simple-0.34
	>=dev-perl/HTTP-Server-Simple-Mason-0.14
	dev-perl/IPC-Run3
	dev-perl/JavaScript-Minifier
	dev-perl/JSON
	dev-perl/libwww-perl
	dev-perl/locale-maketext-fuzzy
	>=dev-perl/locale-maketext-lexicon-0.32
	>=dev-perl/log-dispatch-2.2.3
	>=dev-perl/log-dispatch-2.23
	>=dev-perl/MailTools-1.60
	>=dev-perl/MIME-tools-5.425
	dev-perl/MIME-Types
	dev-perl/Module-Refresh
	>=dev-perl/Module-Versions-Report-1.05
	dev-perl/Net-CIDR
	dev-perl/net-server
	dev-perl/PerlIO-eol
	dev-perl/Plack
	dev-perl/regexp-common
	dev-perl/Regexp-Common-net-CIDR
	dev-perl/Regexp-IPv6
	dev-perl/Starlet
	dev-perl/TermReadKey
	dev-perl/text-autoformat
	dev-perl/Text-Password-Pronounceable
	>=dev-perl/Text-Quoted-2.02
	dev-perl/text-template
	>=dev-perl/Text-WikiFormat-0.76
	dev-perl/text-wrapper
	dev-perl/Time-modules
	dev-perl/TimeDate
	>=dev-perl/Tree-Simple-1.04
	dev-perl/UNIVERSAL-require
	>=dev-perl/XML-RSS-1.05
	>=virtual/perl-CGI-3.38
	virtual/perl-digest-base
	>=virtual/perl-Digest-MD5-2.27
	>=virtual/perl-File-Spec-0.8
	virtual/perl-File-Temp
	>=virtual/perl-Getopt-Long-2.24
	virtual/perl-libnet
	>=virtual/perl-locale-maketext-1.06
	virtual/perl-Scalar-List-Utils
	>=virtual/perl-Storable-2.08
	virtual/perl-Time-HiRes

	fastcgi? (
		dev-perl/FCGI
		dev-perl/FCGI-ProcManager
	)
	!lighttpd? ( dev-perl/Apache-DBI )
	lighttpd? ( dev-perl/FCGI )
	mysql? ( >=dev-perl/DBD-mysql-2.1018 )
	postgres? ( >=dev-perl/DBD-Pg-1.43 )
"

RDEPEND="${DEPEND}
	virtual/mta
	!lighttpd? ( ${APACHE2_DEPEND} )
	lighttpd? (
		>=www-servers/lighttpd-1.3.13
		sys-apps/openrc
	)
"

need_httpd_cgi

add_user_rt() {
	# add new user
	# suexec2 requires uid >= 1000; enewuser is of no help here
	# From: Mike Frysinger <vapier@gentoo.org>
	# Date: Fri, 17 Jun 2005 08:41:44 -0400
	# i'd pick a 5 digit # if i were you

	local euser="rt"

	# first check if username rt exists
	if [[ ${euser} == $(egetent passwd "${euser}" | cut -d: -f1) ]] ; then
		# check uid
		rt_uid=$(egetent passwd "${euser}" | cut -d: -f3)
		if $(expr ${rt_uid} '<' 1000 > /dev/null); then
			ewarn "uid of user rt is less than 1000. suexec2 will not work."
			ewarn "If you want to use FastCGI, please delete the user 'rt'"
			ewarn "from your system and re-emerge www-apps/rt"
		fi
		return 0 # all is well
	fi

	# add user
	# stolen from enewuser
	local pwrange euid

	pwrange=$(seq 10001 11001)
	for euid in ${pwrange} ; do
		[[ -z $(egetent passwd ${euid}) ]] && break
	done
	if [[ ${euid} == "11001" ]]; then
		# she gets around, doesn't she?
		die "No available uid's found"
	fi

	elog " - Userid: ${euid}"

	enewuser rt ${euid} -1 /dev/null rt
	return 0
}

pkg_setup() {
	webapp_pkg_setup

	ewarn
	ewarn "If you are upgrading from an existing RT installation"
	ewarn "make sure to read the related upgrade documentation in"
	ewarn "${ROOT}usr/share/doc/${PF}."
	ewarn

	enewgroup rt
	add_user_rt || die "Could not add user"
}

src_prepare() {
	# add Gentoo-specific layout
	cat "${FILESDIR}"/config.layout-gentoo >> config.layout
	sed -e "s|PREFIX|${D}/${MY_HOSTROOTDIR}/${PF}|
			s|HTMLDIR|${D}/${MY_HTDOCSDIR}|g" -i ./config.layout || die

	# don't need to check dev dependencies
	sed -e "s|\$args{'with-DEV'} =1;|#\$args{'with-DEV'} =1;|" -i sbin/rt-test-dependencies.in || die
}

src_configure() {
	local web myconf depsconf

	if use mysql ; then
		myconf+=" --with-db-type=mysql --with-db-dba=root"
		depsconf+=" --with-mysql"
	fi
	if use postgres ; then
		myconf+=" --with-db-type=Pg --with-db-dba=postgres"
		depsconf+=" --with-postgresql"
	fi
	if use postgres && use mysql ; then
		ewarn "Both mysql and postgres USE flags enabled, default is mysql."
		ewarn "You can set the default value in RT_SiteConfig before DB init."
		myconf+=" --with-db-type=mysql --with-db-dba=root"
		depsconf+=" --with-mysql"
	fi

	if use fastcgi ; then
		myconf+=" --with-web-handler=fastcgi"
		web="apache"
		depsconf+=" --with-fastcgi"
	elif use lighttpd ; then
		myconf+=" --with-web-handler=fastcgi"
		web="lighttpd"
		depsconf+=" --with-fastcgi"
	else
		myconf+=" --with-web-handler=modperl2"
		web="apache"
		depsconf+=" --with-modperl2"
	fi

	./configure --enable-layout=Gentoo \
		--with-bin-owner=rt \
		--with-libs-owner=rt \
		--with-libs-group=rt \
		--with-rt-group=rt \
		--with-web-user=${web} \
		--with-web-group=${web} \
		${myconf}

	# check for missing deps and ask to report if something is broken
	/usr/bin/perl ./sbin/rt-test-dependencies ${depsconf} > "${T}"/t
	if grep -q "MISSING" "${T}"/t; then
		ewarn "Missing Perl dependency!"
		ewarn
		cat "${T}"/t | grep MISSING
		ewarn
		ewarn "Please run perl-cleaner. If the problem persists,"
		ewarn "please file a bug in the Gentoo Bugzilla with the information above"
		die "Missing dependencies."
	fi
}

src_compile() { :; }

src_install() {
	webapp_src_preinst
	emake install

	dodoc "${S}"/docs/UPGRADING*
	dodoc "${S}"/docs/*.pod
	dodoc "${S}"/docs/network-diagram.svg
	cp -R "${S}"/docs/customizing/ "${D}"/usr/share/doc/"${P}"/
	cp -R "${S}"/docs/extending/ "${D}"/usr/share/doc/"${P}"/

	# make sure we don't clobber existing site configuration
	rm -f "${D}"/${MY_HOSTROOTDIR}/${PF}/etc/RT_SiteConfig.pm

	# fix paths
	find "${D}" -type f -print0 | xargs -0 sed -i -e "s:${D}::g"

	# copy upgrade files
	insinto "${MY_HOSTROOTDIR}/${PF}"
	doins -r etc/upgrade

	if use lighttpd ; then
		newinitd "${FILESDIR}"/${PN}.init.d.2 ${PN}
		newconfd "${FILESDIR}"/${PN}.conf.d.2 ${PN}
		sed -i -e "s/@@PF@@/${PF}/g" "${D}"/etc/conf.d/${PN} || die
	else
		doins "${FILESDIR}"/{rt_apache2_fcgi.conf,rt_apache2.conf}
	fi

	# require the web server's permissions
	webapp_serverowned "${MY_HOSTROOTDIR}"/${PF}/var
	webapp_serverowned "${MY_HOSTROOTDIR}"/${PF}/var/mason_data/obj

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_hook_script "${FILESDIR}"/reconfig

	webapp_src_install
}

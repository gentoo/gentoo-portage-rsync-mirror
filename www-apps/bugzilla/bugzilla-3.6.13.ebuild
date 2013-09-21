# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugzilla/bugzilla-3.6.13.ebuild,v 1.3 2013/09/21 10:55:52 ago Exp $

EAPI="3"

inherit webapp depend.apache versionator eutils

MY_PB=$(get_version_component_range 1-2)

DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/webtools/archived/${P}.tar.gz"
HOMEPAGE="http://www.bugzilla.org"

LICENSE="MPL-1.1"
KEYWORDS="amd64 x86"

IUSE="modperl extras graphviz mysql postgres"

RDEPEND="
	virtual/httpd-cgi
	>=dev-lang/perl-5.8.8

	>=dev-perl/DBI-1.601
	>=dev-perl/DateTime-0.50
	>=dev-perl/DateTime-Locale-0.43
	>=dev-perl/DateTime-TimeZone-0.71
	>=dev-perl/URI-1.38
	>=dev-perl/Email-MIME-1.900
	>=dev-perl/Email-MIME-Encodings-1.313
	>=dev-perl/Email-Send-2.190
	>=dev-perl/MIME-tools-5.427
	>=dev-perl/Template-Toolkit-2.22
	>=dev-perl/TimeDate-1.16
	>=virtual/perl-CGI-3.510
	>=virtual/perl-Digest-SHA-5.46
	>=virtual/perl-File-Spec-3.27.01
	>=virtual/perl-MIME-Base64-3.07

	mysql? ( >=dev-perl/DBD-mysql-4.00.5 )
	postgres? ( >=dev-perl/DBD-Pg-1.49 )
	graphviz? ( media-gfx/graphviz )

	modperl? (
		>=dev-perl/Apache-DBI-1.06
		www-apache/mod_perl:1
	)

	extras? (
		dev-perl/Authen-SASL
		>=dev-perl/Chart-2.4.1
		dev-perl/Email-MIME-Attachment-Stripper
		dev-perl/Email-Reply
		>=dev-perl/GD-2.35
		dev-perl/GDGraph
		dev-perl/GDTextUtil
		>=dev-perl/HTML-Parser-3.60
		dev-perl/HTML-Scrubber
		dev-perl/JSON-RPC
		dev-perl/libwww-perl
		>=dev-perl/PatchReader-0.9.5
		dev-perl/perl-ldap
		dev-perl/SOAP-Lite
		dev-perl/Template-GD
		dev-perl/Test-Taint
		dev-perl/XML-Twig
		|| ( media-gfx/imagemagick[perl] media-gfx/graphicsmagick[imagemagick,perl] )
		dev-perl/TheSchwartz
		dev-perl/Daemon-Generic
		dev-perl/Math-Random-Secure
	)
"
# from extras we miss:
# (nothing)

want_apache modperl

pkg_setup() {
	depend.apache_pkg_setup modperl
	webapp_pkg_setup
}

src_prepare() {
	ecvs_clean
	# Remove bundled perl modules
	rm -rf "${S}"/lib || die
}

src_install () {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r . || die
	for f in bugzilla.cron.daily bugzilla.cron.tab; do
		doins "${FILESDIR}"/${MY_PB}/${f} || die
	done

	webapp_hook_script "${FILESDIR}"/${MY_PB}/reconfig
	webapp_postinst_txt en "${FILESDIR}"/${MY_PB}/postinstall-en.txt
	webapp_src_install

	# bug #124282
	chmod +x "${D}${MY_HTDOCSDIR}"/*.cgi
	# configuration must be executable
	chmod u+x "${D}${MY_HTDOCSDIR}"/checksetup.pl
}

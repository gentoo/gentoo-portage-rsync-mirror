# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/clive/clive-2.2.6.ebuild,v 1.6 2009/11/25 10:23:22 maekke Exp $

EAPI=2

inherit perl-app

DESCRIPTION="Command line tool for extracting videos from various websites"
HOMEPAGE="http://clive.sourceforge.net/"
SRC_URI="http://clive.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="clipboard pager password"

RDEPEND=">=dev-perl/BerkeleyDB-0.34
	>=dev-perl/Config-Tiny-2.12
	>=virtual/perl-Digest-SHA-5.47
	>=dev-perl/HTML-TokeParser-Simple-2.37
	>=dev-perl/Class-Singleton-1.4
	>=dev-perl/WWW-Curl-4.05
	>=dev-perl/XML-Simple-2.18
	>=dev-perl/Getopt-ArgvFile-1.11
	virtual/perl-Getopt-Long
	virtual/perl-File-Spec
	clipboard? ( >=dev-perl/Clipboard-0.09 )
	pager? ( >=dev-perl/IO-Pager-0.05 )
	password? ( >=dev-perl/Expect-1.21 )"
DEPEND=""

SRC_TEST=do
mydoc="TODO"

src_test() {
	if [ -z "${I_WANT_CLIVE_HOSTS_TESTS}" ] ; then
		elog "If you wish to run the full testsuite of ${PN}"
		elog "Please set the variable 'I_WANT_CLIVE_HOSTS_TESTS' variable"
		elog "Note that the tests try to download some videos from various websites"
		elog "and thus may randomly fail depending on the site's status."
		export NO_INTERNET=1
	fi
	perl-module_src_test
}

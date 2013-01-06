# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Test/Apache-Test-1.380.0.ebuild,v 1.8 2012/12/27 11:03:54 armin76 Exp $

EAPI=4

MODULE_AUTHOR=PHRED
MODULE_VERSION=1.38
inherit depend.apache perl-module

DESCRIPTION="Test.pm wrapper with helpers for testing Apache"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

# interactive, requires interaction with the live filesystem
SRC_TEST="skip"

need_apache

pkg_setup() {
	perl-module_pkg_setup
}

src_install() {
	# This is to avoid conflicts with a deprecated Apache::Test stepping
	# in and causing problems/install errors
	if [ -f  "${S}"/.mypacklist ];
	then
		rm -f "${S}"/.mypacklist
	fi
	perl-module_src_install
}

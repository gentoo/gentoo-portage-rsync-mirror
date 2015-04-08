# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RPC-XML/RPC-XML-0.770.0-r1.ebuild,v 1.2 2014/11/28 22:14:02 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=RJRAY
MODULE_VERSION=0.77
inherit perl-module

DESCRIPTION="An implementation of XML-RPC"

SLOT="0"
LICENSE="|| ( Artistic-2 LGPL-2.1 )"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

RDEPEND="
	>=dev-perl/libwww-perl-5.834.0
	>=dev-perl/XML-LibXML-1.850.0
	>=dev-perl/XML-Parser-2.310.0
	dev-perl/net-server
	>=virtual/perl-Scalar-List-Utils-1.200.0
	dev-perl/URI
"
DEPEND="${RDEPEND}"

pkg_postinst() {
	SETWARN=0
	has_version '=www-servers/apache-2*' && HAVE_APACHE2=1
	has_version '>=www-apache/mod_perl-2.0' && HAVE_MP2=2

	[ -n "${HAVE_APACHE2}" ] && SETWARN=1
	[ -n "${HAVE_MP2}" ] && SETWARN=1

	if [ "${SETWARN}" == "1" ]; then
	ewarn "Apache2 or mod_perl2 were detected."
	ewarn ""
	ewarn "NOTE FROM THE AUTHOR OF RPC-XML"
	ewarn ""
	ewarn "At present, this package does not work with Apache2 and the soon-to-be"
	ewarn "mod_perl2. The changes to the API for location handlers are too drastic to"
	ewarn "try and support both within the same class (I tried, using the compatibility"
	ewarn "layer). Also, mp2 does not currently provide support for <Perl> sections, which"
	ewarn "are the real strength of the Apache::RPC::Server class."
	fi
}

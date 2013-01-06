# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP-Lite/SOAP-Lite-0.715.0.ebuild,v 1.6 2012/10/17 03:14:34 phajdan.jr Exp $

EAPI=4

MODULE_AUTHOR=MKUTTER
MODULE_VERSION=0.715
inherit perl-module eutils

DESCRIPTION="Simple and lightweight interface to the SOAP protocol (sic) both on client and server side"

IUSE="jabber ssl"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux"

myconf="${myconf} --noprompt"

# TESTS ARE DISABLED ON PURPOSE
# This module attempts to access an external website for validation
# of the MIME::Parser - not only is that bad practice in general,
# but in this particular case the external site isn't even valid anymore# -mpc
# 24/10/04
SRC_TEST="do"

DEPEND="
	dev-perl/Class-Inspector
	dev-perl/XML-Parser
	dev-perl/libwww-perl
	virtual/perl-libnet
	dev-perl/MIME-Lite
	virtual/perl-MIME-Base64
	ssl? ( dev-perl/Crypt-SSLeay )
	jabber? ( dev-perl/Net-Jabber )
	ssl? ( dev-perl/IO-Socket-SSL )
	virtual/perl-IO-Compress
	>=dev-perl/MIME-tools-5.413
	virtual/perl-version
"
RDEPEND="${DEPEND}"

src_prepare() {
	# The author of this module put a dep for MIME::Parser 6.X - but the6.X
	# release of MIME::Parser was a mistake during a change in maintainers on
	# cpan. This patch alters the dependancy to the "real" stable version of
	# MIME::Parser.
	epatch "${FILESDIR}"/SOAP-Lite-0.710.08.patch
	# Merged upstream
	#epatch "${FILESDIR}"/${PN}-0.712_sysread.patch
}

src_test() {
	has_version '>=www-apache/mod_perl-2' && export MOD_PERL_API_VERSION=2
	perl-module_src_test
}

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/DB_File/DB_File-1.827.0.ebuild,v 1.10 2013/02/21 14:45:42 ago Exp $

EAPI=4

MODULE_AUTHOR=PMQS
MODULE_VERSION=1.827
inherit perl-module multilib eutils

DESCRIPTION="A Berkeley DB Support Perl Module"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="sys-libs/db"
DEPEND="${RDEPEND}"

SRC_TEST="do"

src_prepare() {
	if [[ $(get_libdir) != "lib" ]] ; then
		sed -i "s:^LIB.*:LIB = /usr/$(get_libdir):" "${S}"/config.in || die
	fi
	epatch "${FILESDIR}"/DB_File-MakeMaker.patch
}

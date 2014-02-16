# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/NetAddr-IP/NetAddr-IP-4.66.0.ebuild,v 1.11 2014/02/16 09:43:57 zlogene Exp $

EAPI=4

MODULE_AUTHOR=MIKER
MODULE_VERSION=4.066
inherit perl-module

DESCRIPTION="Manipulation and operations on IP addresses"

SLOT="0"
LICENSE="|| ( Artistic Artistic-2 )"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="ipv6"

RDEPEND="ipv6? ( dev-perl/Socket6 )"
DEPEND="${RDEPEND}"

SRC_TEST="do"

src_prepare() {
	perl-module_src_prepare
	touch "${S}"/Makefile.old
}

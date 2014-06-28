# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-pkgconfig/extutils-pkgconfig-1.130.0.ebuild,v 1.11 2014/06/28 18:02:04 zlogene Exp $

EAPI=4

MY_PN=ExtUtils-PkgConfig
MODULE_AUTHOR=XAOC
MODULE_VERSION=1.13
inherit perl-module

DESCRIPTION="Simplistic perl interface to pkg-config"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

DEPEND="virtual/pkgconfig"

SRC_TEST="do"

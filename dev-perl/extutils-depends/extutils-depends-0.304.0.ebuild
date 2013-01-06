# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-depends/extutils-depends-0.304.0.ebuild,v 1.9 2012/05/16 12:54:02 aballier Exp $

EAPI=4

MY_PN=ExtUtils-Depends
MODULE_AUTHOR=FLORA
MODULE_VERSION=0.304
inherit perl-module

DESCRIPTION="Easily build XS extensions that depend on XS extensions"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

SRC_TEST="do parallel"

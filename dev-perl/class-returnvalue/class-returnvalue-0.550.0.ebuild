# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/class-returnvalue/class-returnvalue-0.550.0.ebuild,v 1.2 2011/09/03 21:04:39 tove Exp $

EAPI=4

MY_PN=Class-ReturnValue
MODULE_AUTHOR=JESSE
MODULE_VERSION=0.55
inherit perl-module

DESCRIPTION="A return-value object that lets you treat it as as a boolean, array or object"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

RDEPEND="dev-perl/Devel-StackTrace"
DEPEND="${RDEPEND}"

SRC_TEST="do"

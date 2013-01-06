# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GnuPG-Interface/GnuPG-Interface-0.450.0.ebuild,v 1.6 2012/05/28 16:05:39 armin76 Exp $

EAPI=4

MODULE_AUTHOR=ALEXMV
MODULE_VERSION=0.45
inherit perl-module

DESCRIPTION="GnuPG::Interface is a Perl module interface to interacting with GnuPG."

SLOT="0"
KEYWORDS="amd64 hppa ppc x86 ~ppc-macos"
IUSE=""

RDEPEND=">=app-crypt/gnupg-1.2.1-r1
	>=virtual/perl-Math-BigInt-1.78
	dev-perl/Any-Moose"
DEPEND="${RDEPEND}"

SRC_TEST="do"

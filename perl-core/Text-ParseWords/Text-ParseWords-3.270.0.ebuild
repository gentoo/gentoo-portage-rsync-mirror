# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Text-ParseWords/Text-ParseWords-3.270.0.ebuild,v 1.2 2012/06/24 06:56:34 tove Exp $

EAPI=4

MODULE_AUTHOR="CHORNY"
MODULE_A_EXT="zip"
MODULE_VERSION=3.27

inherit perl-module

DESCRIPTION="Parse strings containing shell-style quoting"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"

SRC_TEST="do"

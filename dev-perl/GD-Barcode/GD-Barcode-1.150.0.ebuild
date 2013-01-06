# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD-Barcode/GD-Barcode-1.150.0.ebuild,v 1.2 2011/09/03 21:05:11 tove Exp $

EAPI=4

MODULE_AUTHOR=KWITKNR
MODULE_VERSION=1.15
inherit perl-module

DESCRIPTION="GD::Barcode - Create barcode image with GD"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-perl/GD"
DEPEND="${RDEPEND}"

SRC_TEST="do"

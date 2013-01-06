# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IP-Anonymous/IP-Anonymous-0.40.0.ebuild,v 1.2 2011/09/03 21:04:38 tove Exp $

EAPI=4

MODULE_AUTHOR=JTK
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="Perl port of Crypto-PAn to provide anonymous IP addresses"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="dev-perl/Crypt-Rijndael"
DEPEND="${RDEPEND}"

SRC_TEST="do"

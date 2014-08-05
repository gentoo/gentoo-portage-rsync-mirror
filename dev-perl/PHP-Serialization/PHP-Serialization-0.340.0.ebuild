# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PHP-Serialization/PHP-Serialization-0.340.0.ebuild,v 1.2 2014/08/05 13:21:59 zlogene Exp $

EAPI=4

MODULE_AUTHOR=BOBTFISH
MODULE_VERSION=0.34
inherit perl-module

DESCRIPTION="Convert PHP's serialize() into the equivalent Perl structure, and vice versa"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

SRC_TEST=do

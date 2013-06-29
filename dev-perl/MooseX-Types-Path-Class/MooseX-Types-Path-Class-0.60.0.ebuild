# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Types-Path-Class/MooseX-Types-Path-Class-0.60.0.ebuild,v 1.2 2013/06/29 18:30:34 zlogene Exp $

EAPI=4

MODULE_AUTHOR=THEPLER
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="A Path::Class type library for Moose"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/Moose-1.990
	>=dev-perl/Moose-0.390.0
	>=dev-perl/MooseX-Types-0.40.0
	>=dev-perl/Path-Class-0.160.0"

DEPEND="${RDEPEND}"

SRC_TEST="do"

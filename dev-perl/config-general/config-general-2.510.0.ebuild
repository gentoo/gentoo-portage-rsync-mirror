# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/config-general/config-general-2.510.0.ebuild,v 1.7 2012/11/30 06:11:02 bicatali Exp $

EAPI=4

MY_PN=Config-General
MODULE_AUTHOR=TLINDEN
MODULE_VERSION=2.51
inherit perl-module

DESCRIPTION="Config file parser module"

SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

SRC_TEST="do"

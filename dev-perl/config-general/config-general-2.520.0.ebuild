# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/config-general/config-general-2.520.0.ebuild,v 1.1 2013/08/15 06:51:32 patrick Exp $

EAPI=4

MY_PN=Config-General
MODULE_AUTHOR=TLINDEN
MODULE_VERSION=2.52
inherit perl-module

DESCRIPTION="Config file parser module"

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

SRC_TEST="do"

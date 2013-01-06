# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/EV/EV-4.110.0.ebuild,v 1.1 2012/06/16 19:16:20 tove Exp $

EAPI=4

MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=4.11
inherit perl-module

DESCRIPTION="Perl interface to libev, a high performance full-featured event loop"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/common-sense"
DEPEND="${RDEPEND}"

SRC_TEST="do parallel"

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Flock/File-Flock-2014.10.0.ebuild,v 1.1 2014/09/28 21:59:32 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=MUIR
MODULE_VERSION=2014.01
MODULE_SECTION=modules
inherit perl-module

DESCRIPTION="flock() wrapper.  Auto-create locks"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"

RDEPEND="
	dev-perl/Data-Structure-Util
	dev-perl/IO-Event
	dev-perl/AnyEvent
	dev-perl/Event
"
DEPEND="${RDEPEND}
	dev-perl/File-Slurp
"

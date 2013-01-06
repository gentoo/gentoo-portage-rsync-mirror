# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Daemon-Generic/Daemon-Generic-0.820.0.ebuild,v 1.1 2012/03/17 11:38:57 tove Exp $

EAPI=4

MODULE_AUTHOR=MUIR
MODULE_SECTION=modules
MODULE_VERSION=0.82
inherit perl-module

DESCRIPTION="Framework to provide start/stop/reload for a daemon"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND="
	dev-perl/File-Flock
	dev-perl/File-Slurp
	dev-perl/AnyEvent
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Eval-LineNumbers
	)
"

SRC_TEST="do"

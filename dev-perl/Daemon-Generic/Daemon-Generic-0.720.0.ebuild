# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Daemon-Generic/Daemon-Generic-0.720.0.ebuild,v 1.1 2011/05/21 07:57:55 tove Exp $

EAPI=4

MODULE_AUTHOR=MUIR
MODULE_SECTION=modules
MODULE_VERSION=0.72
inherit perl-module

DESCRIPTION="Framework to provide start/stop/reload for a daemon"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/File-Flock
	dev-perl/File-Slurp"
RDEPEND="${DEPEND}"

SRC_TEST="do"

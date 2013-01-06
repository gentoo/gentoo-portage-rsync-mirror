# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Daemon-Generic/Daemon-Generic-0.71.ebuild,v 1.6 2011/01/27 19:12:51 xarthisius Exp $

EAPI=3

MODULE_AUTHOR="MUIR"
MODULE_SECTION="modules"

inherit perl-module

DESCRIPTION="Framework to provide start/stop/reload for a daemon"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-perl/File-Flock
	dev-perl/File-Slurp"
RDEPEND="${DEPEND}"

SRC_TEST="do"

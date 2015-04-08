# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lirc-Client/Lirc-Client-1.540.0-r1.ebuild,v 1.1 2014/08/24 00:45:08 axs Exp $

EAPI=5

MODULE_AUTHOR=MGRIMES
MODULE_VERSION=1.54
inherit perl-module

DESCRIPTION="A client library for the Linux Infrared Remote Control (LIRC)"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/File-Path-Expand
	dev-perl/Class-Accessor"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

# tests succeed - only tested without lirc - tove
#SRC_TEST=do

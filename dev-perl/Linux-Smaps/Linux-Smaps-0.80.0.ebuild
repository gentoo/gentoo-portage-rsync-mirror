# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Linux-Smaps/Linux-Smaps-0.80.0.ebuild,v 1.1 2011/03/31 06:19:34 tove Exp $

EAPI=4

MODULE_AUTHOR=OPI
MODULE_VERSION=0.08
inherit perl-module linux-info

DESCRIPTION="Linux::Smaps - a Perl interface to /proc/PID/smaps"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CONFIG_CHECK="~MMU ~PROC_PAGE_MONITOR"

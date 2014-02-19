# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Crontab/Config-Crontab-1.400.0.ebuild,v 1.1 2014/02/19 10:53:37 radhermit Exp $

EAPI=5

MODULE_AUTHOR=SCOTTW
MODULE_VERSION=1.40
inherit perl-module

DESCRIPTION="Read/Write Vixie compatible crontab(5) files"

SLOT="0"
KEYWORDS="~amd64 ~x86"

SRC_TEST="do"

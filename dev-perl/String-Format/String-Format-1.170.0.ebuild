# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/String-Format/String-Format-1.170.0.ebuild,v 1.4 2013/03/31 09:54:38 ago Exp $

EAPI=4

MODULE_AUTHOR=DARREN
MODULE_VERSION=1.17
inherit perl-module

DESCRIPTION="sprintf-like string formatting capabilities with arbitrary format definitions"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"

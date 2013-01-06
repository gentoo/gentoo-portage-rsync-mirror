# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Danga-Socket/Danga-Socket-1.610.0.ebuild,v 1.3 2011/09/05 18:22:15 tove Exp $

EAPI=4

MODULE_AUTHOR=BRADFITZ
MODULE_VERSION=1.61
inherit perl-module

DESCRIPTION="A non-blocking socket object; uses epoll()"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-perl/Sys-Syscall"
DEPEND="${RDEPEND}"

SRC_TEST="do"

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Syscall/Sys-Syscall-0.230.0.ebuild,v 1.2 2011/09/05 18:19:47 tove Exp $

EAPI=4

MODULE_AUTHOR=BRADFITZ
MODULE_VERSION=0.23
inherit perl-module

DESCRIPTION="Access system calls that Perl doesn't normally provide access to"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SRC_TEST="do"

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MP3-Tag/MP3-Tag-1.130.0.ebuild,v 1.6 2012/03/03 14:17:06 ranger Exp $

EAPI=4

MODULE_AUTHOR=ILYAZ
MODULE_VERSION=1.13
MODULE_SECTION=modules
inherit perl-module

DESCRIPTION="Tag - Module for reading tags of mp3 files"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST="do"

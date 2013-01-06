# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Quoted/Text-Quoted-2.60.0.ebuild,v 1.2 2011/09/03 21:04:41 tove Exp $

EAPI=4

MODULE_AUTHOR=RUZ
MODULE_VERSION=2.06
inherit perl-module

DESCRIPTION="Extract the structure of a quoted mail message"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="dev-perl/text-autoformat"
DEPEND="${RDEPEND}"

SRC_TEST="do"

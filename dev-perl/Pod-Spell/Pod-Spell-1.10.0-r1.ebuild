# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Spell/Pod-Spell-1.10.0-r1.ebuild,v 1.1 2014/08/22 21:07:18 axs Exp $

EAPI=5

MODULE_AUTHOR=SBURKE
MODULE_VERSION=1.01
inherit perl-module

DESCRIPTION="A formatter for spellchecking Pod"
SRC_URI+=" mirror://gentoo/podspell.1.gz http://dev.gentoo.org/~tove/files/podspell.1.gz"

SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="virtual/perl-Pod-Escapes
	virtual/perl-Pod-Parser"
DEPEND="${RDEPEND}"

SRC_TEST="do"

src_install() {
	perl-module_src_install
	doman "${WORKDIR}"/podspell.1 || die
}

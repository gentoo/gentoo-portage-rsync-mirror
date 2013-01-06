# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/digest-md2/digest-md2-2.30.0.ebuild,v 1.2 2011/09/03 21:05:20 tove Exp $

EAPI=4

MY_PN=Digest-MD2
MODULE_AUTHOR=GAAS
MODULE_VERSION=2.03
inherit perl-module

DESCRIPTION="Perl interface to the MD2 Algorithm"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST=do

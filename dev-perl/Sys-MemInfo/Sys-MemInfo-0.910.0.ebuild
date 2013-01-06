# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-MemInfo/Sys-MemInfo-0.910.0.ebuild,v 1.9 2012/03/17 17:56:15 armin76 Exp $

EAPI=4

MODULE_AUTHOR=SCRESTO
MODULE_VERSION=0.91
inherit perl-module

DESCRIPTION="Memory informations"

# sources specify LGPL-2.1, README "same terms as Perl itself"
LICENSE="LGPL-2.1 ${LICENSE}"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${PN}

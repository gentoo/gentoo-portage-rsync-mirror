# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libvorbis-perl/libvorbis-perl-0.50.0.ebuild,v 1.2 2011/09/03 21:04:29 tove Exp $

EAPI=4

MODULE_AUTHOR=FOOF
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="Ogg::Vorbis - Perl extension for Ogg Vorbis streams"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND="media-libs/libogg
	media-libs/libvorbis"
DEPEND="${RDEPEND}"

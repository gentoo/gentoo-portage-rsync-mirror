# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ebook-tools/ebook-tools-0.2.2.ebuild,v 1.4 2012/10/20 16:10:48 jdhore Exp $

EAPI=4

inherit cmake-utils multilib

DESCRIPTION="Tools for accessing and converting various ebook file formats."
HOMEPAGE="http://sourceforge.net/projects/ebook-tools"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 x86"
IUSE=""

DEPEND="dev-libs/libxml2
	dev-libs/libzip"
RDEPEND="${DEPEND}
	app-text/convertlit"

DOCS=( INSTALL README TODO )

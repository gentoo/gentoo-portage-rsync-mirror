# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/shared-color-profiles/shared-color-profiles-0.1.4.ebuild,v 1.11 2013/01/22 07:24:29 tetromino Exp $

EAPI="4"

DESCRIPTION="Color profiles from contributors for color calibration"
HOMEPAGE="https://github.com/hughsie/shared-color-profiles"
SRC_URI="http://people.freedesktop.org/~hughsient/releases/${P}.tar.gz"

LICENSE="GPL-2 MIT ZLIB public-domain"
SLOT="0"
KEYWORDS="amd64 arm hppa ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND="!>=x11-misc/colord-0.1.27"
DEPEND=""

DOCS=(AUTHORS ChangeLog NEWS README)

src_prepare() {
	# Install profile subdirectory documentation in /usr/share/doc/${PF}
	# Note: we install LICENSE files because each subdirectory has a different
	# license, origin, and author, which the user may be interested in knowing.
	sed -e "/licensedir/s:/shared-color-profiles/:/doc/${PF}/:" \
		-i profiles/*/Makefile.* || die "sed profiles/*/Makefile.* failed"
}

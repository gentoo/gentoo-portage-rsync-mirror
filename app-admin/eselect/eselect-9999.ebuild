# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect/eselect-9999.ebuild,v 1.10 2012/06/09 14:02:29 ulm Exp $

EAPI=4

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/eselect.git"
EGIT_BOOTSTRAP="autogen.bash"

inherit git-2 bash-completion-r1

DESCRIPTION="Gentoo's multi-purpose configuration and management tool"
HOMEPAGE="http://www.gentoo.org/proj/en/eselect/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND="sys-apps/sed
	|| (
		sys-apps/coreutils
		sys-freebsd/freebsd-bin
		app-misc/realpath
	)"
DEPEND="${RDEPEND}
	doc? ( dev-python/docutils )"
RDEPEND="!app-admin/eselect-news
	${RDEPEND}
	sys-apps/file
	sys-libs/ncurses"

# Commented out: only few users of eselect will edit its source
#PDEPEND="emacs? ( app-emacs/gentoo-syntax )
#	vim-syntax? ( app-vim/eselect-syntax )"

src_compile() {
	emake
	use doc && emake html
}

src_install() {
	emake DESTDIR="${D}" install
	newbashcomp misc/${PN}.bashcomp ${PN}
	dodoc AUTHORS ChangeLog NEWS README TODO doc/*.txt
	use doc && dohtml *.html doc/*

	# needed by news module
	keepdir /var/lib/gentoo/news
	fowners root:portage /var/lib/gentoo/news || die
	fperms g+w /var/lib/gentoo/news || die
}

pkg_postinst() {
	# fowners in src_install doesn't work for the portage group:
	# merging changes the group back to root
	chgrp portage "${EROOT}/var/lib/gentoo/news" \
		&& chmod g+w "${EROOT}/var/lib/gentoo/news"
}

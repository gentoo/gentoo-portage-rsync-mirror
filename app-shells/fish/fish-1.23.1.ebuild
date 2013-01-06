# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/fish/fish-1.23.1.ebuild,v 1.6 2011/07/07 10:41:38 polynomial-c Exp $

EAPI="3"

inherit base autotools

DESCRIPTION="fish is the Friendly Interactive SHell"
HOMEPAGE="http://fishshell.com/"
SRC_URI="http://fishshell.com/files/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="X"

DEPEND="sys-libs/ncurses
	sys-devel/bc
	sys-devel/gettext
	www-client/htmlview
	X? ( x11-misc/xsel )"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-1.23.0-glibc-2.8.patch"
	"${FILESDIR}/${PN}-1.22.3-gettext.patch"
	"${FILESDIR}/${P}-gentoo-alt.patch"
)

src_prepare() {
	base_src_prepare

	eautoreconf
}

src_configure() {
	# Set things up for fish to be a default shell.
	# It has to be in /bin in case /usr is unavailable.
	# Also, all of its utilities have to be in /bin.
	econf \
		docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--without-xsel \
		--bindir="${EPREFIX}"/bin
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}

pkg_postinst() {
	elog
	elog "To use ${PN} as your default shell, you need to add ${EPREFIX}/bin/${PN}"
	elog "to ${EPREFIX}/etc/shells."
	elog
	ewarn "Many files moved to ${EROOT}usr/share/fish/completions from ${EROOT}etc/fish.d/."
	ewarn "Delete everything in ${EROOT}etc/fish.d/ except fish_interactive.fish."
	ewarn "Otherwise, fish won't notice updates to the installed files,"
	ewarn "because the ones in /etc will override the new ones in /usr."
	echo
}

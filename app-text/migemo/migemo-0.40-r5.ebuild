# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/migemo/migemo-0.40-r5.ebuild,v 1.2 2012/12/11 15:53:35 jer Exp $

EAPI=4
# ruby19, jruby: dev-ruby/ruby-romkan not work
USE_RUBY="ruby18 ree18"

inherit autotools elisp-common eutils ruby-ng

DESCRIPTION="Migemo is Japanese Incremental Search Tool"
HOMEPAGE="http://0xcc.net/migemo/"
SRC_URI="http://0xcc.net/migemo/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="emacs"

ruby_add_bdepend "dev-ruby/ruby-romkan dev-ruby/bsearch"

DEPEND="${DEPEND}
	app-dicts/migemo-dict[-unicode]
	emacs? ( virtual/emacs
		app-emacs/apel )"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

RUBY_PATCHES=(
	"${FILESDIR}/${PF}-without-emacs.patch"
	"${FILESDIR}/${P}-ruby-ng.patch"
)

all_ruby_prepare() {
	cp "${EPREFIX}"/usr/share/migemo/migemo-dict .
	eautoreconf
}

each_ruby_configure() {
	RUBY="${RUBY}" econf $(use_with emacs) --with-lispdir="${SITELISP}/${PN}"
}

each_ruby_install() {
	emake DESTDIR="${D}" \
		$(use emacs || echo "lispdir=") install
}

all_ruby_install() {
	rm "${ED}"/usr/share/migemo/migemo-dict

	if use emacs; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
	dodoc AUTHORS ChangeLog INSTALL README
}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
		elog "Migemo adviced search is no longer enabled as a site default."
		elog "Add the following line to your ~/.emacs file to enable it:"
		elog "  (require 'migemo)"
	fi
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/rabbit/rabbit-1.0.9.ebuild,v 1.1 2012/07/27 17:33:54 graaff Exp $

EAPI=4
USE_RUBY="ruby18"

inherit ruby-ng elisp-common eutils

DESCRIPTION="An application to do presentation with RD document"
HOMEPAGE="http://rabbit-shockers.org/"
SRC_URI="http://rabbit-shockers.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls migemo tgif enscript emacs markdown postscript"

CDEPEND="emacs? ( virtual/emacs )"
DEPEND="${DEPEND} ${CDEPEND}"
RDEPEND="${RDEPEND} ${CDEPEND}
	nls? ( dev-ruby/ruby-gettext )
	postscript? ( app-text/ghostscript-gpl )
	migemo? ( app-text/migemo )
	enscript? ( app-text/enscript )
	tgif? ( media-gfx/tgif )"

ruby_add_bdepend "emacs? ( dev-ruby/rdtool[emacs] )"
ruby_add_rdepend "
	>=dev-ruby/coderay-1.0.0
	>=dev-ruby/ruby-gdkpixbuf2-0.15.0
	dev-ruby/ruby-gtk2
	dev-ruby/ruby-poppler
	>=dev-ruby/ruby-rsvg-1.0.3
	dev-ruby/rdtool[emacs?]
	dev-ruby/haml
	markdown? ( dev-ruby/kramdown )
	dev-ruby/sinatra
	enscript? ( dev-ruby/nokogiri )
	emacs? ( dev-ruby/nokogiri ) "

each_ruby_configure() {
	${RUBY} setup.rb config --prefix=/usr || die
	${RUBY} setup.rb setup || die
}

all_ruby_compile() {
	if use emacs; then
		cd "${S}/misc/emacs"
		elisp-compile rabbit-mode.el
	fi
}

each_ruby_install() {
	${RUBY} setup.rb install --prefix="${D}"
}

all_ruby_install() {
	dodoc -r doc

	insinto /usr/share/doc/${PF}
	doins -r sample

	if use emacs; then
		cd "${S}/misc/emacs"
		elisp-install rabbit-mode rabbit-mode.el{,c}
		elisp-site-file-install "${FILESDIR}/50rabbit-mode-gentoo.el"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/rabbit/rabbit-0.9.2.ebuild,v 1.2 2012/06/16 16:35:04 ssuominen Exp $

EAPI=2
USE_RUBY="ruby18"

inherit ruby-ng elisp-common eutils

DESCRIPTION="An application to do presentation with RD document"
HOMEPAGE="http://www.cozmixng.org/~rwiki/?cmd=view;name=Rabbit"
SRC_URI="http://www.cozmixng.org/~kou/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls postscript migemo tgif enscript emacs"

CDEPEND="emacs? ( virtual/emacs )"
DEPEND="${DEPEND} ${CDEPEND}"
RDEPEND="${RDEPEND} ${CDEPEND}
	nls? ( dev-ruby/ruby-gettext )
	postscript? ( app-text/ghostscript-gpl )
	migemo? ( app-text/migemo )
	enscript? ( app-text/enscript )
	tgif? ( media-gfx/tgif )"

ruby_add_rdepend "
	>=dev-ruby/ruby-gdkpixbuf2-0.15.0
	dev-ruby/ruby-gtk2
	dev-ruby/ruby-poppler
	dev-ruby/ruby-rsvg
	dev-ruby/rdtool"

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

each_ruby_test() {
	${RUBY} test/run-test.rb || die "Tests failed."
}

each_ruby_install() {
	${RUBY} setup.rb install --prefix="${D}"
}

all_ruby_install() {
	dodoc NEWS.en NEWS.ja README.en README.ja TODO || die

	if use emacs; then
		cd "${S}/misc/emacs"
		elisp-install rabbit-mode rabbit-mode.el{,c}
		elisp-site-file-install "${FILESDIR}/50rabbit-mode-gentoo.el"
	fi

	insinto /usr/share/doc/${PF}
	doins -r sample
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

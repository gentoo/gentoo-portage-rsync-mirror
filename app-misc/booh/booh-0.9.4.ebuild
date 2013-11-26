# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/booh/booh-0.9.4.ebuild,v 1.1 2013/11/26 01:29:40 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19"

inherit eutils bash-completion-r1 ruby-ng

DESCRIPTION="Static HTML photo album generator"
HOMEPAGE="http://booh.org/index.html"
SRC_URI="http://booh.org/packages/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk encode exif"

CDEPEND="media-gfx/exiv2
	gtk? ( >=x11-libs/gtk+-2.8:2 )"

DEPEND="${DEPEND} ${CDEPEND}"
RDEPEND="${RDEPEND} ${CDEPEND}
	|| ( media-gfx/imagemagick[jpeg,png] media-gfx/graphicsmagick[jpeg,png] )
	exif? ( media-gfx/exif )
	encode? ( media-video/mplayer )"

ruby_add_rdepend "
	>=dev-ruby/ruby-gettext-0.8.0
	dev-ruby/ruby-glib2
	gtk? ( >=dev-ruby/ruby-gtk2-0.12 )"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${PN}-0.9.2.2-stdc.patch

	# Remove scripts requiring gtk if gtk is not used
	if ! use gtk; then
		rm bin/booh bin/booh-classifier bin/booh-fix-whitebalance \
		bin/booh-gamma-correction || die
	fi
	sed -i -e 's/-48x48.png//' desktop/booh-classifier.desktop || die
	sed -i -e 's/-48x48.png//' desktop/booh.desktop || die
}

each_ruby_configure() {
	${RUBY} setup.rb config || die "ruby setup.rb config failed"
	${RUBY} setup.rb setup || die "ruby setup.rb setup failed"
	cd ext
	${RUBY} extconf.rb || die "ruby extconf.rb failed"
	sed -i -e 's:-Wl,--no-undefined ::' -e 's:-Wl,-R$(libdir)::'\
		-e 's:-Wl,-R -Wl,$(libdir)::' Makefile || die
}

each_ruby_compile() {
	emake -Cext V=1
}

each_ruby_install() {
	${RUBY} setup.rb install \
		--prefix="${D}" || die "ruby setup.rb install failed"
	cd ext
	emake install V=1 \
		DESTDIR="${D}" \
		libdir="${D}"/$(${RUBY} -rrbconfig -e "puts Config::CONFIG['sitelibdir']") \
		archdir="${D}"/$({$RUBY} -rrbconfig -e "puts Config::CONFIG['sitearchdir']")
	cd ..
}

all_ruby_install() {
	domenu desktop/booh-classifier.desktop desktop/booh.desktop
	newicon -s 48 desktop/booh-48x48.png booh.png
	dobashcomp booh.bash-completion
	dodoc AUTHORS ChangeLog INTERNALS README VERSION THEMES
}

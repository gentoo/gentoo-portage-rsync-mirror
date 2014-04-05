# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mini_magick/mini_magick-3.7.0.ebuild,v 1.2 2014/04/05 14:42:58 mrueg Exp $

EAPI=5

# jruby → test_tempfile_at_path_after_format fails with jruby 1.3.1,
# sounds like a bug in JRuby itself, or the code not being compatible.
USE_RUBY="ruby19 ruby20 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem eutils

DESCRIPTION="Manipulate images with minimal use of memory."
HOMEPAGE="http://github.com/minimagick/minimagick"
SRC_URI="https://github.com/minimagick/minimagick/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RUBY_S="minimagick-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# It's only used at runtime in this case because this extension only
# _calls_ the commands. But when we run tests we're going to need tiff
# and jpeg support at a minimum.
RDEPEND+=" media-gfx/imagemagick"
DEPEND+=" test? ( media-gfx/imagemagick[tiff,jpeg] )"

ruby_add_rdepend ">=dev-ruby/subexec-0.2.1"

ruby_add_bdepend "test? ( dev-ruby/mocha )"

all_ruby_prepare() {
	# remove executable bit from all files
	find "${S}" -type f -exec chmod -x {} +

	sed -i -e '/[Bb]undler/ s:^:#:' spec/spec_helper.rb || die

	# Don't force a specific formatter but use overall Gentoo defaults.
	sed -i -e '/config.formatter/d' spec/spec_helper.rb || die
}

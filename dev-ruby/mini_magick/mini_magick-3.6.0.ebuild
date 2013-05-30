# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mini_magick/mini_magick-3.6.0.ebuild,v 1.1 2013/05/30 17:42:34 flameeyes Exp $

EAPI=5

# jruby → test_tempfile_at_path_after_format fails with jruby 1.3.1,
# sounds like a bug in JRuby itself, or the code not being compatible.
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_RECIPE_DOC=""

inherit ruby-fakegem eutils

DESCRIPTION="Manipulate images with minimal use of memory."
HOMEPAGE="http://github.com/probablycorey/mini_magick"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# It's only used at runtime in this case because this extension only
# _calls_ the commands. But when we run tests we're going to need tiff
# and jpeg support at a minimum.
RDEPEND="media-gfx/imagemagick"
DEPEND="test? ( media-gfx/imagemagick[tiff,jpeg] )"

# tests are known to fail under imagemagick 6.5 at least, reported upstream:
# http://github.com/probablycorey/mini_magick/issues/#issue/2
# update: still fails with imagemagick 6.6.
ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

ruby_add_rdepend ">=dev-ruby/subexec-0.1.0"

RUBY_PATCHES=( "${P}+ruby18.patch" )

all_ruby_prepare() {
	# remove executable bit from all files
	find "${S}" -type f -exec chmod -x {} +

	# Remove spec definition part because the gemspec file is not included
	sed -i -e '/gemspec/,$ d' Rakefile || die

	sed -i -e '/[Bb]undler/ s:^:#:' Rakefile || die
}

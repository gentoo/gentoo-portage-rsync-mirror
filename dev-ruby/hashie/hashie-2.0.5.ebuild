# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hashie/hashie-2.0.5.ebuild,v 1.1 2013/07/18 01:25:53 mrueg Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.markdown"

inherit ruby-fakegem

DESCRIPTION="Hashie is a small collection of tools that make hashes more powerful."
HOMEPAGE="http://intridea.com/posts/hashie-the-hash-toolkit"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

all_ruby_prepare() {
	# Remove bundler
	rm Gemfile || die
	sed -i -e '/[Bb]undler/d' Rakefile || die
}

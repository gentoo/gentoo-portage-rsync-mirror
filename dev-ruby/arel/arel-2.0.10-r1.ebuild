# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/arel/arel-2.0.10-r1.ebuild,v 1.6 2012/05/12 18:00:24 flameeyes Exp $

EAPI="2"
USE_RUBY="ruby18 ree18 jruby ruby19"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.markdown"

# Use the ruby specifications since parsing the yaml metadata causes
# jruby to crash.
RUBY_FAKEGEM_GEMSPEC="arel.gemspec"

inherit ruby-fakegem

DESCRIPTION="Arel is a Relational Algebra for Ruby."
HOMEPAGE="http://github.com/rails/arel"
LICENSE="MIT"
SLOT="2.0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-solaris"
IUSE=""

ruby_add_bdepend "
	doc? ( >=dev-ruby/hoe-2.6.2 )
	test? (
		>=dev-ruby/hoe-2.6.2
		virtual/ruby-minitest
	)"

all_ruby_prepare() {
	# Fix the version number in the gemspec.
	sed -i -e 's/2.0.9.20110222133018/2.0.10/' arel.gemspec || die
}

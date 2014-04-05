# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/color/color-1.4.2-r1.ebuild,v 1.2 2014/04/05 14:16:28 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 jruby"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="History.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Colour management with Ruby"
HOMEPAGE="http://color.rubyforge.org/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend "
	test? (
		>=dev-ruby/hoe-2.5.0
		>=dev-ruby/minitest-5.0
		dev-ruby/rubyforge
		virtual/ruby-minitest
	)"

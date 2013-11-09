# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/uglifier/uglifier-2.3.1.ebuild,v 1.1 2013/11/09 19:30:29 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

inherit ruby-fakegem

DESCRIPTION="Ruby wrapper for UglifyJS JavaScript compressor."
HOMEPAGE="https://github.com/lautis/uglifier"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

IUSE="test"

ruby_add_rdepend ">=dev-ruby/execjs-0.3.0 >=dev-ruby/json-1.8.0"

ruby_add_bdepend "test? ( dev-ruby/source_map )"

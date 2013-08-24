# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/uglifier/uglifier-2.1.2.ebuild,v 1.2 2013/08/24 15:03:00 maekke Exp $

EAPI=5
USE_RUBY="ruby19"

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

ruby_add_rdepend ">=dev-ruby/execjs-0.3.0 >=dev-ruby/multi_json-1.0.2"

ruby_add_bdepend "test? ( dev-ruby/source_map )"

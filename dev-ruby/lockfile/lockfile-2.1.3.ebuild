# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/lockfile/lockfile-2.1.3.ebuild,v 1.2 2014/04/24 20:12:29 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="A ruby library for creating NFS safe lockfiles"
HOMEPAGE="https://github.com/ahoward/lockfile"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
